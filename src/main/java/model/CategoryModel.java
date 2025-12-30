package model;

public class CategoryModel {

	private int cateid;
	private String catename;
	private String icon;
    private String description;
    
	public CategoryModel(int cateid, String catename, String icon) {
		super();
		this.cateid = cateid;
		this.catename = catename;
		this.icon = icon;
	}
	public CategoryModel() {
		// TODO Auto-generated constructor stub
	}
	//Tạo constructor, getters/setters
	public int getCateid() {
		return cateid;
	}
	public void setCateid(int cateid) {
		this.cateid = cateid;
	}
	public String getCatename() {
		return catename;
	}
	public void setCatename(String catename) {
		this.catename = catename;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	 // new getter/setter for description
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}