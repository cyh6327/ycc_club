package com.youngtvjobs.ycc.course;

import java.util.Objects;

public class CourseImageDto {
	
	private String uuid; // uuid(pk, 중복방지 랜덤문자생성) 
	private String fileName; // 파일 이름 
	private String uploadPath; // 경로 
	private int course_id; // 강좌 id 
	
	public CourseImageDto() { }

	public CourseImageDto(String uuid, String fileName, String uploadPath, int course_id) {
		// super();
		this.uuid = uuid;
		this.fileName = fileName;
		this.uploadPath = uploadPath;
		this.course_id = course_id;
	}

	@Override
	public int hashCode() {
		return Objects.hash(course_id, fileName, uploadPath, uuid);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CourseImageDto other = (CourseImageDto) obj;
		return course_id == other.course_id && Objects.equals(fileName, other.fileName)
				&& Objects.equals(uploadPath, other.uploadPath) && Objects.equals(uuid, other.uuid);
	}

	@Override
	public String toString() {
		return "CourseImageDto [uuid=" + uuid + ", fileName=" + fileName + ", uploadPath=" + uploadPath + ", course_id="
				+ course_id + "]";
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

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public int getCourse_id() {
		return course_id;
	}

	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}
	
}
