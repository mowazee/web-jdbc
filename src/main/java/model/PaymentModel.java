package model;

import java.io.Serializable;
import java.sql.Date;

public class PaymentModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int orderid;
	private double amount;
	private String method;
	private int status;
	private Date paymentdate;
	private String transactionid;

	public PaymentModel() {
	}

	public PaymentModel(int id, int orderid, double amount, String method, int status, Date paymentdate,
			String transactionid) {
		this.id = id;
		this.orderid = orderid;
		this.amount = amount;
		this.method = method;
		this.status = status;
		this.paymentdate = paymentdate;
		this.transactionid = transactionid;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOrderid() {
		return orderid;
	}

	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getPaymentdate() {
		return paymentdate;
	}

	public void setPaymentdate(Date paymentdate) {
		this.paymentdate = paymentdate;
	}

	public String getTransactionid() {
		return transactionid;
	}

	public void setTransactionid(String transactionid) {
		this.transactionid = transactionid;
	}
}