package model;

import java.io.Serializable;
import java.sql.Date;

public class NewModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String title;
	private String content;
	private String preview;
	private String thumbnail;
	private String image; // new
	private Date createdate;
	private int authorid;
	private int cateid;
	private int viewCount; // new

	public NewModel() {
	}

	public NewModel(int id, String title, String content, String preview, String thumbnail, Date createdate,
			int authorid,int cateid) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.preview = preview;
		this.thumbnail = thumbnail;
		this.createdate = createdate;
		this.authorid = authorid;
		this.cateid = cateid;
	}

	// getters/setters
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public String getTitle() { return title; }
	public void setTitle(String title) { this.title = title; }
	public String getContent() { return content; }
	public void setContent(String content) { this.content = content; }
	public String getPreview() { return preview; }
	public void setPreview(String preview) { this.preview = preview; }
	public String getThumbnail() { return thumbnail; }
	public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
	public String getImage() { return image; }
	public void setImage(String image) { this.image = image; }
	public Date getCreatedate() { return createdate; }
	public void setCreatedate(Date createdate) { this.createdate = createdate; }
	public int getAuthorid() { return authorid; }
	public void setAuthorid(int authorid) { this.authorid = authorid; }
	public int getCateid() { return cateid; }
	public void setCateid(int cateid) { this.cateid = cateid; }
	public int getViewCount() { return viewCount; }
	public void setViewCount(int viewCount) { this.viewCount = viewCount; }
}