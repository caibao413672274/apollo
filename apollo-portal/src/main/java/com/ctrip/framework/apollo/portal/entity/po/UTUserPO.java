package com.ctrip.framework.apollo.portal.entity.po;

import com.ctrip.framework.apollo.portal.entity.bo.UserInfo;

import javax.persistence.*;

/**
 * 友和道通用户类
 * @author
 */
@Entity
@Table(name = "UnitopUsers")
public class UTUserPO {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "Id")
  private long id;
  @Column(name = "Username", nullable = false)
  private String username;
  @Column(name = "userId", nullable = false)
  private String userId;
  @Column(name = "Email")
  private String email;
  @Column(name = "OrgNo")
  private String orgNo;
  @Column(name = "OrgName")
  private String orgName;
  @Column(name = "stationNo")
  private String stationNo;
  @Column(name = "stationName")
  private String stationName;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
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

  public UserInfo toUserInfo() {
    UserInfo userInfo = new UserInfo();
    userInfo.setName(this.getUsername());
    userInfo.setUserId(this.getUserId());
    userInfo.setEmail(this.getEmail());
    userInfo.setStationName(this.getStationName());
    userInfo.setOrgName(this.getOrgName());
    userInfo.setStationNo(this.getStationNo());
    userInfo.setOrgNo(this.getOrgNo());
    return userInfo;
  }
}
