# Shell-script
An object-oriented programming simulation in shell script with file manager
modules:
	- 1 class
	- 1 type
	- design unit trong software

Ideals of modular software:
	- Có thể phân nhỏ để giảm độ phức tạp
	- Có thể gộp
	- Dễ hiểu
	- Tính liên tục: 1 thay đổi ảnh hưởng đến số ít module
	- Cô lập: tỉ lệ lỗi trong chỉ 1 module càng nhiều càng tốt

Top-down, bottom-up

Cohesion và coupling là tiêu chí quan trọng nhất để đánh giá
design

high cohesion: các mô-đun độc lập, tránh nhiều nhiệm vụ trong 1 module, tên nó thể hiện chính nó

low coupling: tương tác tối thiểu với các mô-đun khác, interface đơn giản

______

Đánh giá coupling

- Degree: degree là số lượng kết nối giữa 1 module và các
	module khác.
	+ Nếu kết nối qua 1 vài parameters hoặc interfaces hẹp thì sẽ là low coupling

- Ease (giảm bớt):
	+ Dễ dàng kết nối với lớp khác mà k cần hiểu triển khai của nó
- Flexibility (mềm dẻo):
	+ Dễ dàng, linh hoạt cho việc thay thế module (module tốt hơn)


Range of coupling:
	- Content coupling
	- Common coupling
	- Control coupling
	- Stamp coupling
	- Data coupling
	- Uncoupled
_______________
Content coupling:
	+ Tham chiếu 1 component đến contents khác
	+ VD:
		- Component sửa đổi trực tiếp dữ liệu của
			component khác
		- Component sửa đổi code code của component
		khác, vd: jumps into the middle of a routine
		=> Cách khắc phục: private, get, set method

Common coupling:
	- Một số modules chia sẻ bên ngoài data format, giao thức
	truyền thông hoặc device interface

	+ Cùng tham chiếu một biến số global (sử dụng biến
	global)
	
Control Coupling:
	- Component vượt quá kiểm soát parameters với thành phần được ghép nối
	- Phải biết bên trong component khác thực hiện code ntn

Stamp Coupling:
	- Truyền vượt quá số refers cần sử dụng 

Data coupling:
	- Truyền data (không phải cấu trúc dữ liệu) cho component khác
Uncoupled:
	- Không ghép nối không phải là hệ thống.
________________________

Cohesion:
- Mức độ mà tất cả elements của 1 component hướng đến 1 nhiệm
vụ duy nhất và tất cả yếu tố hướng đến nhiệm vụ đó.

Rangle of cohesion:
- Low Cohesion (khó hiểu):
	+ Sự gắn kết ngẫu nhiên (coincidental cohesion
	+ Gắn kết logic (logical cohesion)
	+ Gắn kết theo thời gian (temporal cohesion)
- Moderate Cohesion (cohesion vừa phải - có thể chấp nhận đc)
	+ Procedural cohesion
	+ Communicational Cohesion
	+ Sequential cohesion
- High cohesion (desirable)
	+ Functional cohesion

___________________________
Coincidental Cohesion:
	Các elements của component chỉ liên quan đến vị trí của
	chúng trong mã nguồn. (không liên quan đến các elements khác
	trong component.
	- Rất ngẫu nhiên, chưa rõ chức năng chính

Logical Cohesion:
	Các elements liên quan với nhau về mặt logic, không
	liên quan với nhau về mặt chức năng

Temporal Cohesion:
	Các elemet của một component liên quan với nhau 
	theo thời gian (ví dụ cùng thời điểm)
	+ KHó thay đổi, phải xem xét các component liên quan
	+ Tăng khả năng xảy ra lỗi hồi quy
	+ Component không thể tái sử dụng


Procedural Cohesion:
	+ Các elements liên quan đến nhau, đảm bảo 1 thứ tự
	thực hiện
	+ Các hành động vẫn liên kết yếu với nhau, vẫn
	không thể tái sử dụng
	=> Theo trình tự thời gian, tuy nhiên không có lý do để
	đặt thành 1 mô-đun

Communicational Cohesion:
	Là khi một mô-đun được nhóm lại vì chúng hoạt
	động trên 1 dữ liệu (cùng input, output data hoặc
	truy cập và sửa đổ cùng 1 phần của data structure)

Sequence cohesion:
	Sự gán kết của module theo tuần tự, đầu vào thành
	phần này là đầu ra thành phần tiếp theo.

Infomation Cohesion:
	Mô-đun có mỗi hành động có 1 entry point, code
	độc lập cho mỗi hành động, tất cả thực hiện trên
	cùng 1 dữ liệu. (khác communicational ở chỗ 
	là entry point)
	
functional cohesion:
	Mọi element cần thiết để tính toán đơn (single
	computation) được chứa trong component.
	+Được cho là tồn tại nếu các element khác nhau
	của 1 module hợp tác để đạt được 1 chức năng duy 
	nhất

Communicational Cohesion vs Infomation Cohesion:
