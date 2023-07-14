-- SQL DATA ANALYSIS (DANNY'S DINNER DATASET)

-- TẠO DỮ LIỆU 
CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

-- ANALYSIS

select * from sales
select * from menu
select * from members


-- 1. TỔNG SỐ TIỀN MÀ MỖI KHÁCH HÀNG ĐÃ CHI TẠI NHÀ HÀNG LÀ BAO NHIÊU?

select customer_id, sum(price) total_spent
from sales s
join menu m
on s.product_id = m.product_id
group by customer_id

-- 2. How many days has each customer visited the restaurant?

select customer_id, count(distinct order_date) days_visited
from sales 
group by customer_id;

-- 3. MÓN ĂN ĐẦU TIÊN MÀ TỪNG KHÁCH HÀNG ĐÃ MUA TẠI NHÀ HÀNG LÀ GÌ?

with first_order as
(
select customer_id, product_name, Dense_rank() over (partition by customer_id order by order_date) rank
from sales s 
join menu m 
on s.product_id = m.product_id
) 
select customer_id, product_name
from first_order
where rank = 1

-- 4. MÓN ĂN ĐƯỢC ORDER NHIỀU NHẤT LÀ GÌ VÀ NÓ ĐÃ ĐƯỢC MUA BAO NHIÊU LẦN BỞI TẤT CẢ KHÁCH HÀNG?

select top 1 m.product_name, count(s.product_id) order_count
from sales s 
join menu m 
on s.product_id = m.product_id
group by m.product_name
order by order_count desc

-- 5. MỖI KHÁCH HÀNG ĐÃ ORDER MÓN ĂN NÀO NHIỀU NHẤT?

with most_order as
(
SELECT customer_id, product_name, (Dense_rank() over (partition by customer_id order by count(s.product_id) desc)) rank
from sales s 
join menu m 
on s.product_id = m.product_id
group by customer_id, product_name
)
select customer_id, product_name
from most_order
where rank = 1

-- 6. MÓN ĂN NÀO ĐƯỢC TỪNG KHÁCH HÀNG MUA ĐẦU TIÊN SAU KHI HỌ TRỞ THÀNH MEMBER?
with member_sales as 
(
select mem.customer_id, order_date, product_id, (Dense_rank() over (partition by mem.customer_id order by order_date)) rank 
from sales s 
join members mem on s.customer_id = mem.customer_id
where order_date >= join_date
)
select customer_id, product_name
from member_sales ms 
join menu m on ms.product_id = m.product_id
where rank = 1

-- 7. MÓN NÀO ĐƯỢC TỪNG KHÁCH HÀNG MUA NGAY TRƯỚC KHI HỌ TRỞ THÀNH MEMBER?

with member_sales as 
(
select mem.customer_id, order_date, product_id, (Dense_rank() over (partition by mem.customer_id order by order_date desc)) rank 
from sales s 
join members mem on s.customer_id = mem.customer_id
where order_date < join_date
)
select customer_id, product_name
from member_sales ms 
join menu m on ms.product_id = m.product_id
where rank = 1

-- 8. TỔNG LƯỢNG ITEM VÀ SỐ TIỀN ĐÃ CHI CỦA TỪNG KHÁCH HÀNG TRƯỚC KHI HỌ TRỞ THÀNH MEMBER? 

SELECT s.customer_id, COUNT(*) as total_items, SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id

-- 9.  NẾU MỖI SỐ TIỀN CHI $1 LÀ 10 ĐIỂM, SUSHI SẼ LÀ X2 ĐIỂM - MỖI KHÁCH HÀNG SẼ CÓ BAO NHIÊU ĐIỂM?

select customer_id, sum
(case 
    when product_name = 'sushi' then price*20
    else price*10
    end) as total_point
from sales s 
join menu m on s.product_id = m.product_id 
group by customer_id;

-- 10. TRONG TUẦN ĐẦU TIÊN TRỞ THÀNH MEMBER, KHÁCH HÀNG ĐƯỢC X2 SỐ ĐIỂM - TÍNH ĐIỂM CỦA KHÁCH HÀNG A VÀ B?

select mem.customer_id, sum
(
case 
    when product_name = 'sushi' then price*20
    when s.order_date between join_date and DATEADD(day, 6, join_date) then price*20
    else price*10
    end
) total_points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
where mem.customer_id in ('A','B') and s.order_date <= '2021-01-31'
group by mem.customer_id

-- 11. TẠO BẢNG DỮ LIỆU ĐỂ CÓ THỂ NHANH CHÓNG RÚT RA CÁC THÔNG TIN CẦN THIẾT

SELECT s.customer_id, s.order_date, m.product_name, m.price, 
CASE WHEN s.order_date >= mb.join_date THEN 'Y' 
ELSE 'N' 
END as member
FROM dbo.sales s
JOIN menu m ON s.product_id = m.product_id
LEFT JOIN members mb ON s.customer_id = mb.customer_id
ORDER BY s.customer_id, s.order_date;

-- 12. TẠO BẢNG XẾP HẠNG SẢN PHẨM KHÁCH HÀNG MEMBER MUA DỰA THEO NGÀY MUA 

with a as
(select s.customer_id, s.order_date, m.product_name, m.price, 
case 
    when order_date < join_date then 'N'
    when order_date >= join_date then 'Y'
    else 'N'
    end as member
from sales s 
join menu m on s.product_id = m.product_id
left join members mem on s.customer_id = mem.customer_id)
select *, case 
                when member = 'N' then Null 
                else rank() over (partition by a.customer_id, member order by a.order_date) 
                end as ranking
from a 

    