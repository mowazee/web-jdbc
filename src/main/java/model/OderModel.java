package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class OderModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int userid;
	private Date orderdate;
	private int status;
	private double total;
	private List<OderItemModel> items = new ArrayList<>();

	public OderModel() {
	}

	public OderModel(int id, int userid, Date orderdate, int status, double total) {
		this.id = id;
		this.userid = userid;
		this.orderdate = orderdate;
		this.status = status;
		this.total = total;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public List<OderItemModel> getItems() {
		return items;
	}

	public void setItems(List<OderItemModel> items) {
		this.items = items;
	}

	public void addItem(OderItemModel item) {
		this.items.add(item);
	}
}