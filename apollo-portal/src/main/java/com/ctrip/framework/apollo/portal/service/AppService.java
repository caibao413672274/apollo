package com.ctrip.framework.apollo.portal.service;

import com.ctrip.framework.apollo.common.dto.AppDTO;
import com.ctrip.framework.apollo.common.dto.PageDTO;
import com.ctrip.framework.apollo.common.entity.App;
import com.ctrip.framework.apollo.common.exception.BadRequestException;
import com.ctrip.framework.apollo.common.utils.BeanUtils;
import com.ctrip.framework.apollo.core.enums.Env;
import com.ctrip.framework.apollo.portal.api.AdminServiceAPI;
import com.ctrip.framework.apollo.portal.constant.TracerEventType;
import com.ctrip.framework.apollo.portal.entity.bo.UserInfo;
import com.ctrip.framework.apollo.portal.entity.po.Role;
import com.ctrip.framework.apollo.portal.entity.vo.EnvClusterInfo;
import com.ctrip.framework.apollo.portal.repository.AppRepository;
import com.ctrip.framework.apollo.portal.spi.UserInfoHolder;
import com.ctrip.framework.apollo.portal.spi.UserService;
import com.ctrip.framework.apollo.portal.spi.unitop.UnitopLocalUserService;
import com.ctrip.framework.apollo.portal.util.CommonUtils;
import com.ctrip.framework.apollo.portal.util.RoleUtils;
import com.ctrip.framework.apollo.tracer.Tracer;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.text.MessageFormat;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AppService {

  private final UserInfoHolder userInfoHolder;
  private final AdminServiceAPI.AppAPI appAPI;
  private final AppRepository appRepository;
  private final ClusterService clusterService;
  private final AppNamespaceService appNamespaceService;
  private final RoleInitializationService roleInitializationService;
  private final RolePermissionService rolePermissionService;
  private final FavoriteService favoriteService;
  private final UserService userService;

  @Autowired
  private UnitopLocalUserService unitopLocalUserService;
  public AppService(
      final UserInfoHolder userInfoHolder,
      final AdminServiceAPI.AppAPI appAPI,
      final AppRepository appRepository,
      final ClusterService clusterService,
      final AppNamespaceService appNamespaceService,
      final RoleInitializationService roleInitializationService,
      final RolePermissionService rolePermissionService,
      final FavoriteService favoriteService,
      final UserService userService) {
    this.userInfoHolder = userInfoHolder;
    this.appAPI = appAPI;
    this.appRepository = appRepository;
    this.clusterService = clusterService;
    this.appNamespaceService = appNamespaceService;
    this.roleInitializationService = roleInitializationService;
    this.rolePermissionService = rolePermissionService;
    this.favoriteService = favoriteService;
    this.userService = userService;
  }


  public List<App> findAll() {
    Iterable<App> apps = appRepository.findAll();
    if (apps == null) {
      return Collections.emptyList();
    }
    return   filterApp(Lists.newArrayList((apps)));
  }

  private List<App> filterApp(List<App> list){
    boolean isadmin= rolePermissionService.isSuperAdmin(userInfoHolder.getUser().getUserId());
    if(isadmin){
      return list;
    }else{
      //找具有查看、修改、发布权限的应用

      List<Role> userRoles = rolePermissionService.findUserRoles(userInfoHolder.getUser().getUserId());
      Set<String> appIds = Sets.newHashSet();
      for (Role role : userRoles) {
        String appId = RoleUtils.extractAppIdFromRoleName(role.getRoleName());

        if (appId != null) {
          appIds.add(appId);
        }
      }
      return list.stream().filter(app->appIds.contains(app.getAppId())).collect(Collectors.toList());
//
//      List<Permission> permissions= rolePermissionService.queryAppWithRoleForUser(userInfoHolder.getUser().getUserId());
//      if(CollectionUtils.isEmpty(permissions))return Collections.emptyList();
//      List<App> result=new ArrayList<App>();
//      for(App app :list) {
//        for (Permission p : permissions) {
//          if (RoleType.isValidRoleType(p.getPermissionType()) && p.getTargetId().startsWith(app.getAppId()+"+")) {
//            result.add(app);
//            break;
//          }
//        }
//      }
//      return result;
    }
  }

  public PageDTO<App> findAll(Pageable pageable) {
//    Page<App> apps = appRepository.findAll(pageable);
//    return new PageDTO<App>(apps.getContent(), pageable, apps.getTotalElements());
List<App> all=findAll();

all= all.stream().skip(pageable.getOffset()).limit(pageable.getPageSize()).collect(Collectors.toList());
    return new PageDTO<App>(all,pageable,all.size());
  }

  public PageDTO<App> searchByAppIdOrAppName(String query, Pageable pageable) {
//    Page<App> apps = appRepository.findByAppIdContainingOrNameContaining(query, query, pageable);
//    return new PageDTO<App>(apps.getContent(), pageable, apps.getTotalElements());
    List<App> apps =filterApp( appRepository.findByAppIdContainingOrNameContaining(query, query));

    apps= apps.stream().skip(pageable.getOffset()).limit(pageable.getPageSize()).collect(Collectors.toList());
    return new PageDTO<App>(apps,pageable,apps.size());
  }

  public List<App> findByAppIds(Set<String> appIds) {
   return filterApp(appRepository.findByAppIdIn(appIds));

  }

  public List<App> findByAppIds(Set<String> appIds, Pageable pageable) {
    return appRepository.findByAppIdIn(appIds, pageable);
  }

  public List<App> findByOwnerName(String ownerName, Pageable page) {
    return appRepository.findByOwnerName(ownerName, page);
  }

  public App load(String appId) {
    App app= appRepository.findByAppId(appId);
    UserInfo userInfo= unitopLocalUserService.getLocalUser(app.getOwnerName());
    if(userInfo!=null){
      app.setOwnerDisplayName(MessageFormat.format("{0}({1})",userInfo.getName(),app.getOwnerName()));
    }
    if(StringUtils.isEmpty(app.getOwnerDisplayName())){
      app.setOwnerDisplayName(app.getOwnerName());
    }
    return app;
  }

  public AppDTO load(Env env, String appId) {
    return appAPI.loadApp(env, appId);
  }

  public void createAppInRemote(Env env, App app) {
    String username = CommonUtils.getOperator(userInfoHolder);
    app.setDataChangeCreatedBy(username);
    app.setDataChangeLastModifiedBy(username);

    AppDTO appDTO = BeanUtils.transform(AppDTO.class, app);
    appAPI.createApp(env, appDTO);
  }

  @Transactional
  public App createAppInLocal(App app) {
    String appId = app.getAppId();
    App managedApp = appRepository.findByAppId(appId);

    if (managedApp != null) {
      throw new BadRequestException(String.format("App already exists. AppId = %s", appId));
    }

    UserInfo owner = userService.findByUserId(app.getOwnerName());
    if (owner == null) {
      throw new BadRequestException("Application's owner not exist.");
    }
    app.setOwnerEmail(owner.getEmail());

    String operator = CommonUtils.getOperator(userInfoHolder);
    app.setDataChangeCreatedBy(operator);
    app.setDataChangeLastModifiedBy(operator);

    App createdApp = appRepository.save(app);

    appNamespaceService.createDefaultAppNamespace(appId);
    roleInitializationService.initAppRoles(createdApp);

    Tracer.logEvent(TracerEventType.CREATE_APP, appId);

    return createdApp;
  }

  @Transactional
  public App updateAppInLocal(App app) {
    String appId = app.getAppId();

    App managedApp = appRepository.findByAppId(appId);
    if (managedApp == null) {
      throw new BadRequestException(String.format("App not exists. AppId = %s", appId));
    }

    managedApp.setName(app.getName());
    managedApp.setOrgId(app.getOrgId());
    managedApp.setOrgName(app.getOrgName());

    String ownerName = app.getOwnerName();
    UserInfo owner = userService.findByUserId(ownerName);
    if (owner == null) {
      throw new BadRequestException(String.format("App's owner not exists. owner = %s", ownerName));
    }
    managedApp.setOwnerName(owner.getUserId());
    managedApp.setOwnerEmail(owner.getEmail());

    String operator = CommonUtils.getOperator(userInfoHolder);
    managedApp.setDataChangeLastModifiedBy(operator);

    return appRepository.save(managedApp);
  }

  public EnvClusterInfo createEnvNavNode(Env env, String appId) {
    EnvClusterInfo node = new EnvClusterInfo(env);
    node.setClusters(clusterService.findClusters(env, appId));
    return node;
  }

  @Transactional
  public App deleteAppInLocal(String appId) {
    App managedApp = appRepository.findByAppId(appId);
    if (managedApp == null) {
      throw new BadRequestException(String.format("App not exists. AppId = %s", appId));
    }
    String operator = CommonUtils.getOperator(userInfoHolder);

    //this operator is passed to com.ctrip.framework.apollo.portal.listener.DeletionListener.onAppDeletionEvent
    managedApp.setDataChangeLastModifiedBy(operator);

    //删除portal数据库中的app
    appRepository.deleteApp(appId, operator);

    //删除portal数据库中的appNamespace
    appNamespaceService.batchDeleteByAppId(appId, operator);

    //删除portal数据库中的收藏表
    favoriteService.batchDeleteByAppId(appId, operator);

    //删除portal数据库中Permission、Role相关数据
    rolePermissionService.deleteRolePermissionsByAppId(appId, operator);

    return managedApp;
  }
}
