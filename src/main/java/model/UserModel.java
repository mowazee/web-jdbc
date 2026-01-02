package model;
import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class UserModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String email;
	private String username;
	private String fullname;
	private String password;
	private String avatar;
	private int roleid;
	private String phone;
	private String address; // new
	private String activationToken; // new
	private int isActive; // 0 = not active, 1 = active
	private Date createdate;
	private String resetToken; // new
	private Timestamp resetTokenExpiry; // new
	public UserModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserModel(String email, String username, String fullname, String password, String avatar, int roleid,
			String phone, Date createdate) {
		super();
		this.email = email;
		this.username = username;
		this.fullname = fullname;
		this.password = password;
		this.avatar = avatar;
		this.roleid = roleid;
		this.phone = phone;
		this.createdate = createdate;
	}
	// new constructor including address
	public UserModel(String email, String username, String fullname, String password, String avatar, int roleid,
			String phone, String address, Date createdate) {
		super();
		this.email = email;
		this.username = username;
		this.fullname = fullname;
		this.password = password;
		this.avatar = avatar;
		this.roleid = roleid;
		this.phone = phone;
		this.address = address;
		this.createdate = createdate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getActivationToken() {
		return activationToken;
	}
	public void setActivationToken(String activationToken) {
		this.activationToken = activationToken;
	}
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	public String getResetToken() {
		return resetToken;
	}
	public void setResetToken(String resetToken) {
		this.resetToken = resetToken;
	}
	public Timestamp getResetTokenExpiry() {
		return resetTokenExpiry;
	}
	public void setResetTokenExpiry(Timestamp resetTokenExpiry) {
		this.resetTokenExpiry = resetTokenExpiry;
	}
	@Override
	public String toString() {
		return "UserModel [id=" + id + ", email=" + email + ", username=" + username + ", fullname=" + fullname
				+ ", password=" + password + ", avatar=" + avatar + ", roleid=" + roleid + ", phone=" + phone
				+ ", address=" + address + ", activationToken=" + activationToken + ", isActive=" + isActive + ", createdate=" + createdate + "]";
	}
}