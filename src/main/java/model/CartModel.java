package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CartModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private List<CartItemModel> items = new ArrayList<>();

	public CartModel() {
	}

	public List<CartItemModel> getItems() {
		return items;
	}

	public void setItems(List<CartItemModel> items) {
		this.items = items;
	}

	public void addItem(CartItemModel item) {
		for (CartItemModel it : items) {
			if (it.getProductId() == item.getProductId()) {
				it.setQuantity(it.getQuantity() + item.getQuantity());
				return;
			}
		}
		items.add(item);
	}

	public void removeItem(int productId) {
		items.removeIf(i -> i.getProductId() == productId);
	}

	public void clear() {
		items.clear();
	}

	public int getTotalQuantity() {
		int total = 0;
		for (CartItemModel it : items) {
			total += it.getQuantity();
		}
		return total;
	}

	public double getTotalPrice() {
		double total = 0;
		for (CartItemModel it : items) {
			total += it.getSubtotal();
		}
		return total;
	}
}