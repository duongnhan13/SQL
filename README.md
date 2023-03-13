# SQL 
## MOMO CASE : 
1	Kết hợp với 'Điểm trung thành' bảng, thêm một cột 'Điểm trung thành'trong bảng 'Giao dịch' với các quy tắc nhất định. Sau đó, tạo một bảng khác có tên 'Xếp hạng mức độ trung thành' trong đó phải bao gồm các cột có tênXếp hạng_tên VàTính_điểm để tính Xếp hạng của mỗi người dùng trên cơ sở hàng ngày. Vào cuối tháng 3 năm 2022, có bao nhiêu người dùng đạt được thứ hạng Vàng?

supermarket	1 points/1000VND GMV	500 points
data	10 points/1000VND GMV	1000 points
cvs	1 points/1000VND GMV	300 points
marketplace	1 points/1000VND GMV	500 points
Coffee chains and Milk tea	1 points/1000VND GMV	500 points
Offline Beverage	1 points/1000VND GMV	300 points

Xếp hạng phải tuân theo các quy tắc/bảng dưới đây:
Class ID	Rank_name	Loyalty Points
1	STANDARD	1 - 999 points
2	SILVER	1000 - 1999 points
3	GOLD	2000 - 4999 points
4	DIAMOND	>= 5000 points
																			
* Lưu ý quan trọng:Điểm được tính cho mỗi giao dịch sẽ hết hạn sau 30 ngày kể từ ngày giao dịch đó được thực hiện - Thứ hạng của người dùng sẽ bị giảm hoặc tăng tương ứng với sự thay đổi của điểm khách hàng thân thiết tích lũy được.																							
																								
2	Kết hợp với 'lợi ích trung thành ' bảng và 'Xếp hạng mức độ trung thành'bảng, thêm cột'%hoàn lại tiền' TRONG 'giao dịch ' lập bảng và tínhtổng chi phí hoàn lại tiền vào tháng 2 năm 2022.	
Class ID	Group	%cashback
2	cvs	5
2	Offline Beverage	5
2	data	5
3	cvs	7
3	Offline Beverage	7
3	data	7
3	marketplace	2
3	supermarket	2
4	cvs	12
4	Offline Beverage	12
4	data	12
4	marketplace	5
4	supermarket	5

* Ghi chú : - Chi phí hoàn tiền có thể được tính bằng nhân % hoàn tiền với GMV- Người dùng chỉ được yêu cầu tối đa 10.000 VND cho mỗi giao dịch																							
Kết hợp thêm truy xuất total refund hàng tuần và khách hàng mới , thay đổi thứ hạng hàng tuần . 

---
Combine with the 'Loyalty Points' table, add a 'Loyalty Points' column in the 'Transaction' table with certain rules. Then, create another table called 'Ranking of Loyalty Level' which must include columns named 'Ranking_name' and 'Points' to calculate the ranking of each user based on a daily basis. At the end of March 2022, how many users achieved the Gold rank?
Supermarket 1 point/1000VND GMV 500 points
Data 10 points/1000VND GMV 1000 points
CVS 1 point/1000VND GMV 300 points
Marketplace 1 point/1000VND GMV 500 points
Coffee chains and Milk tea 1 point/1000VND GMV 500 points
Offline Beverage 1 point/1000VND GMV 300 points

The ranking must follow the rules/table below:
Class ID Rank_name Loyalty Points
1 STANDARD 1 - 999 points
2 SILVER 1000 - 1999 points
3 GOLD 2000 - 4999 points
4 DIAMOND >= 5000 points

* Important note: Points earned for each transaction will expire after 30 days from the date the transaction was made - The user's rank will decrease or increase accordingly with the change in accumulated loyalty points.
2. Combine with the 'Loyalty Benefits' table and the 'Ranking of Loyalty Level' table, add a '%cashback' column in the 'Transaction' table and calculate the total refund cost in February 2022.

Class ID Group %cashback
2 	CVS 	5
2 	Offline Beverage 5
2 Data 5
3 CVS 7
3 Offline Beverage 7
3 Data 7
3 Marketplace 2
3 Supermarket 2
4 CVS 12
4 Offline Beverage 12
4 Data 12
4 Marketplace 5
4 Supermarket 5

* Note: - The refund cost can be calculated by multiplying the %cashback with the GMV. - Users are only required a maximum of 10,000 VND per transaction for cashback.
Combine with tracking total weekly refunds and new customers, change the weekly ranking.
