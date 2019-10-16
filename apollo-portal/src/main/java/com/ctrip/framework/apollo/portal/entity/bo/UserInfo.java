package com.ctrip.framework.apollo.portal.entity.bo;

public class UserInfo {

  private String userId;
  private String name;
  private String email;

  private String orgNo;
  private String orgName;

  private String stationNo;
  private String stationName;
  public UserInfo() {

  }

  public String getStationNo() {
    return stationNo;
  }

  public void setStationNo(String stationNo) {
    this.stationNo = stationNo;
  }

  public String getStationName() {
    return stationName;
  }

  public void setStationName(String stationName) {
    this.stationName = stationName;
  }

  public String getOrgNo() {
    return orgNo;
  }

  public void setOrgNo(String orgNo) {
    this.orgNo = orgNo;
  }

  public String getOrgName() {
    return orgName;
  }

  public void setOrgName(String orgName) {
    this.orgName = orgName;
  }

  public UserInfo(String userId) {
    this.userId = userId;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  @Override
  public boolean equals(Object o) {
    if (o instanceof UserInfo) {

      if (o == this){
        return true;
      }

      UserInfo anotherUser = (UserInfo) o;
      return userId.equals(anotherUser.userId);
    } else {
      return false;
    }

  }
}
