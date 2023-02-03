package com.youngtvjobs.ycc.club;

import java.util.Objects;

import lombok.Data;

@Data
public class ClubImgDto {
	
	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	private int club_id;
	
	public ClubImgDto() {
		// TODO Auto-generated constructor stub
	}

	public ClubImgDto(String uploadPath, String uuid, String fileName, int club_id) {
		super();
		this.uploadPath = uploadPath;
		this.uuid = uuid;
		this.fileName = fileName;
		this.club_id = club_id;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	@Override
	public int hashCode() {
		return Objects.hash(club_id, fileName, uploadPath, uuid);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ClubImgDto other = (ClubImgDto) obj;
		return club_id == other.club_id && Objects.equals(fileName, other.fileName)
				&& Objects.equals(uploadPath, other.uploadPath) && Objects.equals(uuid, other.uuid);
	}

	@Override
	public String toString() {
		return "ClubImgDto [uploadPath=" + uploadPath + ", uuid=" + uuid + ", fileName=" + fileName + ", club_id="
				+ club_id + "]";
	}
	

}
