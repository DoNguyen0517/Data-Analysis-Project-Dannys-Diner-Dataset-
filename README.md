# SQL Data Analysis Project (Danny's Diner Dataset)

### Giới thiệu

Trong thành phố nhộn nhịp, giữa hương thơm của ẩm thực Nhật Bản ngon lành, có một nhà hàng nhỏ duyên dáng được gọi là Danny's Diner. Nó là sản phẩm trí tuệ của Danny, một người đam mê ẩm thực Nhật Bản. Anh ấy đã có một bước nhảy vọt về niềm tin và mở cửa cho những người đam mê sushi, cà ri và mì ramen vào đầu năm 2021. Với ước mơ trong tim và khao khát thành công, Danny's Diner đã bắt đầu hành trình của mình.

Nhưng giống như bất kỳ doanh nhân đầy tham vọng nào, Danny sớm nhận ra rằng việc điều hành một nhà hàng không chỉ liên quan đến việc phục vụ những món ăn ngon miệng. Nó đòi hỏi sự hiểu biết sâu sắc về khách hàng, sở thích và mô hình hành vi của họ. Nhận thức này đã khiến anh bắt tay vào một dự án kinh doanh mới – khai thác sức mạnh của dữ liệu để nâng cao trải nghiệm ăn uống của khách hàng.

### Vấn đề gặp phải 

Danny háo hức tận dụng dữ liệu thu thập được trong vài tháng đầu hoạt động để làm sáng tỏ những hiểu biết quan trọng về khách hàng của mình. Anh ấy khao khát khám phá các kiểu ghé thăm của họ, khám phá số tiền họ chi tiêu và xác định các mục thực đơn yêu thích của họ. Được trang bị kiến ​​thức này, Danny tin rằng anh có thể mang lại trải nghiệm được cá nhân hóa để thu hút khách hàng trung thành của mình quay lại nhiều hơn.

Ngoài ra, Danny mong muốn sử dụng những thông tin chi tiết này để đưa ra quyết định sáng suốt về việc mở rộng chương trình khách hàng thân thiết hiện tại của mình. Tuy nhiên, có một thách thức. Danny và nhóm của anh ấy thiếu kiến ​​thức chuyên môn để tạo các bộ dữ liệu cơ bản và phân tích dữ liệu mà không dựa vào các truy vấn SQL phức tạp.

### Bộ dữ liệu

Để hỗ trợ cho Case Study này, Danny đã ân cần cung cấp ba bộ dữ liệu quan trọng:

Sales - bộ dữ liệu này chứa thông tin có giá trị về các giao dịch diễn ra tại Danny's Diner, bao gồm ID khách hàng, các món trong thực đơn đã đặt và ngày đặt hàng.
Menu – Bao gồm tất cả những sáng tạo ẩm thực thú vị được cung cấp tại nhà hàng bao gồm cà ri, mì ramen và sushi. Nó chứa các chi tiết như tên mặt hàng và giá của chúng.
Members – Bộ dữ liệu này chứa thông tin về thời điểm khách hàng tham gia phiên bản beta của chương trình khách hàng thân thiết của Danny.

### Công cụ sử dụng

SQL Server

### Quy trình thực hiện Phân tích dữ liệu

Giờ đây, tôi có quyền truy cập vào bộ dữ liệu của Danny, tôi có cơ hội phân tích dữ liệu và trả lời những câu hỏi hóc búa của anh ấy. Với kiến ​​thức chuyên môn về dữ liệu của mình, chúng tôi có thể cung cấp cho Danny thông tin chi tiết có giá trị về hành vi, sở thích và thói quen chi tiêu của khách hàng. Được trang bị kiến ​​thức này, Danny có thể đưa ra quyết định dựa trên dữ liệu để nâng cao chương trình khách hàng thân thiết, tạo trải nghiệm cá nhân hóa và thúc đẩy tăng trưởng cho nhà hàng của mình.

Tôi sẽ giúp Danny trả lời 10 câu hỏi sau:
1. TỔNG SỐ TIỀN MÀ MỖI KHÁCH HÀNG ĐÃ CHI TẠI NHÀ HÀNG LÀ BAO NHIÊU?
2. MỖI KHÁCH HÀNG ĐÃ GHÉ THĂM HÀNG ĂN BAO NHIÊU LẦN?
3. MÓN ĂN ĐẦU TIÊN MÀ TỪNG KHÁCH HÀNG ĐÃ MUA TẠI NHÀ HÀNG LÀ GÌ?
4. MÓN ĂN ĐƯỢC ORDER NHIỀU NHẤT LÀ GÌ VÀ NÓ ĐÃ ĐƯỢC MUA BAO NHIÊU LẦN BỞI TẤT CẢ KHÁCH HÀNG?
5. MỖI KHÁCH HÀNG ĐÃ ORDER MÓN ĂN NÀO NHIỀU NHẤT?
6. MÓN ĂN NÀO ĐƯỢC TỪNG KHÁCH HÀNG MUA ĐẦU TIÊN SAU KHI HỌ TRỞ THÀNH MEMBER?
7. MÓN NÀO ĐƯỢC TỪNG KHÁCH HÀNG MUA NGAY TRƯỚC KHI HỌ TRỞ THÀNH MEMBER?
8. TỔNG LƯỢNG ITEM VÀ SỐ TIỀN ĐÃ CHI CỦA TỪNG KHÁCH HÀNG TRƯỚC KHI HỌ TRỞ THÀNH MEMBER? 
9.  NẾU MỖI SỐ TIỀN CHI $1 LÀ 10 ĐIỂM, SUSHI SẼ LÀ X2 ĐIỂM - MỖI KHÁCH HÀNG SẼ CÓ BAO NHIÊU ĐIỂM?
10. TRONG TUẦN ĐẦU TIÊN TRỞ THÀNH MEMBER, KHÁCH HÀNG ĐƯỢC X2 SỐ ĐIỂM - TÍNH ĐIỂM CỦA KHÁCH HÀNG A VÀ B?

Ngoài ra, tôi còn giúp Danny tạo thêm các truy vấn hỗ trợ anh ấy các thông tin cần thiết để có thể ra những quyết định kinh doanh của mình.