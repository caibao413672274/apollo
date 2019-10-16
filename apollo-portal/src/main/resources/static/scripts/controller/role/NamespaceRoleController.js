role_module.controller('NamespaceRoleController',
    ['$scope', '$location', '$window', '$translate', 'toastr', 'AppService', 'UserService', 'AppUtil', 'EnvService',
        'PermissionService',
        function ($scope, $location, $window, $translate, toastr, AppService, UserService, AppUtil, EnvService,
            PermissionService) {

            var params = AppUtil.parseParams($location.$$url);
            $scope.pageContext = {
                appId: params.appid,
                namespaceName: params.namespaceName
            };
            $scope.lookUpRoleSubmitBtnDisabled = false;
            $scope.modifyRoleSubmitBtnDisabled = false;
            $scope.ReleaseRoleSubmitBtnDisabled = false;

            $scope.releaseRoleWidgetId = 'releaseRoleWidgetId';
            $scope.modifyRoleWidgetId = 'modifyRoleWidgetId';
            $scope.lookUpRoleWidgetId = 'lookUpRoleWidgetId';

            $scope.modifyRoleSelectedEnv = "";
            $scope.releaseRoleSelectedEnv = "";
            $scope.lookUpRoleSelectedEnv = "";

            PermissionService.init_app_namespace_permission($scope.pageContext.appId, $scope.pageContext.namespaceName)
                .then(function (result) {

                }, function (result) {
                    toastr.warn(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.InitNamespacePermissionError'));
                });

            PermissionService.has_assign_user_permission($scope.pageContext.appId)
                .then(function (result) {
                    $scope.hasAssignUserPermission = result.hasPermission;
                }, function (reslt) {

                });

            EnvService.find_all_envs()
                .then(function (result) {
                    $scope.envs = result;
                    $scope.envRolesAssignedUsers = {};
                    for (var iLoop = 0; iLoop < result.length; iLoop++) {
                        var env = result[iLoop];
                        PermissionService.get_namespace_env_role_users($scope.pageContext.appId, env, $scope.pageContext.namespaceName)
                            .then(function (result) {
                                $scope.envRolesAssignedUsers[result.env] = result;
                            }, function (result) {
                                toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.GetEnvGrantUserError', { env }));
                            });
                    }
                });

            PermissionService.get_namespace_role_users($scope.pageContext.appId,
                $scope.pageContext.namespaceName)
                .then(function (result) {
                    $scope.rolesAssignedUsers = result;
                }, function (result) {
                    toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.GetGrantUserError'));
                });

            $scope.assignRoleToUser = function (roleType) {
                if ("ReleaseNamespace" === roleType) {
                    var user = $('.' + $scope.releaseRoleWidgetId).select2('data')[0];
                    if (!user) {
                        toastr.warning($translate.instant('Namespace.Role.PleaseChooseUser'));
                        return;
                    }
                    $scope.ReleaseRoleSubmitBtnDisabled = true;
                    var toAssignReleaseNamespaceRoleUser = user.id;
                    var toAssignReleaseNamespaceRoleUserName=user.name+"("+user.id+")";
                    var assignReleaseNamespaceRoleFunc = $scope.releaseRoleSelectedEnv === "" ?
                        PermissionService.assign_release_namespace_role :
                        function (appId, namespaceName, user) {
                            return PermissionService.assign_release_namespace_env_role(appId, $scope.releaseRoleSelectedEnv, namespaceName, user);
                        };

                    assignReleaseNamespaceRoleFunc($scope.pageContext.appId,
                        $scope.pageContext.namespaceName,
                        toAssignReleaseNamespaceRoleUser)
                        .then(function (result) {
                            toastr.success($translate.instant('Namespace.Role.Added'));
                            $scope.ReleaseRoleSubmitBtnDisabled = false;
                            if ($scope.releaseRoleSelectedEnv === "") {
                                $scope.rolesAssignedUsers.releaseRoleUsers.push(
                                    { userId: toAssignReleaseNamespaceRoleUser,name:toAssignReleaseNamespaceRoleUserName });
                            } else {
                                $scope.envRolesAssignedUsers[$scope.releaseRoleSelectedEnv].releaseRoleUsers.push(
                                    { userId: toAssignReleaseNamespaceRoleUser,name:toAssignReleaseNamespaceRoleUserName });
                            }

                            $('.' + $scope.releaseRoleWidgetId).select2("val", "");
                            $scope.releaseRoleSelectedEnv = "";
                        }, function (result) {
                            $scope.ReleaseRoleSubmitBtnDisabled = false;
                            toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.AddFailed'));
                        });
                }  else if ("ModifyNamespace" === roleType){
                    var user = $('.' + $scope.modifyRoleWidgetId).select2('data')[0];
                    if (!user) {
                        toastr.warning($translate.instant('Namespace.Role.PleaseChooseUser'));
                        return;
                    }
                    $scope.modifyRoleSubmitBtnDisabled = true;
                    var toAssignModifyNamespaceRoleUser = user.id;

                    var toAssignModifyNamespaceRoleUserName=user.name+"("+user.id+")";
                    var assignModifyNamespaceRoleFunc = $scope.modifyRoleSelectedEnv === "" ?
                        PermissionService.assign_modify_namespace_role :
                        function (appId, namespaceName, user) {
                            return PermissionService.assign_modify_namespace_env_role(appId, $scope.modifyRoleSelectedEnv, namespaceName, user);
                        };

                    assignModifyNamespaceRoleFunc($scope.pageContext.appId,
                        $scope.pageContext.namespaceName,
                        toAssignModifyNamespaceRoleUser)
                        .then(function (result) {
                            toastr.success($translate.instant('Namespace.Role.Added'));
                            $scope.modifyRoleSubmitBtnDisabled = false;
                            if ($scope.modifyRoleSelectedEnv === "") {
                                $scope.rolesAssignedUsers.modifyRoleUsers.push(
                                    { userId: toAssignModifyNamespaceRoleUser,name:toAssignModifyNamespaceRoleUserName });
                            } else {
                                $scope.envRolesAssignedUsers[$scope.modifyRoleSelectedEnv].modifyRoleUsers.push(
                                    { userId: toAssignModifyNamespaceRoleUser,name:toAssignModifyNamespaceRoleUserName });
                            }
                            $('.' + $scope.modifyRoleWidgetId).select2("val", "");
                            $scope.modifyRoleSelectedEnv = "";
                        }, function (result) {
                            $scope.modifyRoleSubmitBtnDisabled = false;
                            toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.AddFailed'));
                        });
                }else if ("LookUpNamespace" === roleType){
                    var user = $('.' + $scope.lookUpRoleWidgetId).select2('data')[0];
                    if (!user) {
                        toastr.warning($translate.instant('Namespace.Role.PleaseChooseUser'));
                        return;
                    }
                    $scope.lookUpRoleSubmitBtnDisabled = true;
                    var toAssignlookUpNamespaceRoleUser = user.id;
                    var toAssignlookUpNamespaceRoleUserName=user.name+"("+user.id+")";
                    var assignLookUpNamespaceRoleFunc = $scope.lookUpRoleSelectedEnv === "" ?
                        PermissionService.assign_lookup_namespace_role :
                        function (appId, namespaceName, user) {
                            return PermissionService.assign_lookup_namespace_env_role(appId, $scope.lookUpRoleSelectedEnv, namespaceName, user);
                        };

                    assignLookUpNamespaceRoleFunc($scope.pageContext.appId,
                        $scope.pageContext.namespaceName,
                        toAssignlookUpNamespaceRoleUser)
                        .then(function (result) {
                            toastr.success($translate.instant('Namespace.Role.Added'));
                            $scope.lookUpRoleSubmitBtnDisabled = false;
                            if ($scope.lookUpRoleSelectedEnv === "") {
                                $scope.rolesAssignedUsers.lookUpRoleUsers.push(
                                    {userId: toAssignlookUpNamespaceRoleUser,name:toAssignlookUpNamespaceRoleUserName });
                            } else {
                                $scope.envRolesAssignedUsers[$scope.lookUpRoleSelectedEnv].lookUpRoleUsers.push(
                                    {userId: toAssignlookUpNamespaceRoleUser,name:toAssignlookUpNamespaceRoleUserName });
                            }
                            $('.' + $scope.lookUpRoleWidgetId).select2("val", "");
                            $scope.lookUpRoleSelectedEnv = "";
                        }, function (result) {
                            $scope.lookUpRoleSubmitBtnDisabled = false;
                            toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.AddFailed'));
                        });
                }
            };

            $scope.removeUserRole = function (roleType, user, env) {
                if ("ReleaseNamespace" === roleType) {
                    var removeReleaseNamespaceRoleFunc = !env ?
                        PermissionService.remove_release_namespace_role :
                        function (appId, namespaceName, user) {
                            return PermissionService.remove_release_namespace_env_role(appId, env, namespaceName, user);
                        };

                    removeReleaseNamespaceRoleFunc($scope.pageContext.appId,
                        $scope.pageContext.namespaceName,
                        user)
                        .then(function (result) {
                            toastr.success($translate.instant('Namespace.Role.Deleted'));
                            if (!env) {
                                removeUserFromList($scope.rolesAssignedUsers.releaseRoleUsers, user);
                            } else {
                                removeUserFromList($scope.envRolesAssignedUsers[env].releaseRoleUsers, user);
                            }
                        }, function (result) {
                            toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.DeleteFailed'));
                        });
                } else if ("ModifyNamespace" === roleType){
                    var removeModifyNamespaceRoleFunc = !env ?
                        PermissionService.remove_modify_namespace_role :
                        function (appId, namespaceName, user) {
                            return PermissionService.remove_modify_namespace_env_role(appId, env, namespaceName, user);
                        };

                    removeModifyNamespaceRoleFunc($scope.pageContext.appId,
                        $scope.pageContext.namespaceName,
                        user)
                        .then(function (result) {
                            toastr.success($translate.instant('Namespace.Role.Deleted'));
                            if (!env) {
                                removeUserFromList($scope.rolesAssignedUsers.modifyRoleUsers, user);
                            } else {
                                removeUserFromList($scope.envRolesAssignedUsers[env].modifyRoleUsers, user);
                            }
                        }, function (result) {
                            toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.DeleteFailed'));
                        });
                }else if ("LookUpNamespace" === roleType){
                    var removeLookUpNamespaceRoleFunc = !env ?
                        PermissionService.remove_lookup_namespace_role :
                        function (appId, namespaceName, user) {
                            return PermissionService.remove_lookup_namespace_env_role(appId, env, namespaceName, user);
                        };

                    removeLookUpNamespaceRoleFunc($scope.pageContext.appId,
                        $scope.pageContext.namespaceName,
                        user)
                        .then(function (result) {
                            toastr.success($translate.instant('Namespace.Role.Deleted'));
                            if (!env) {
                                removeUserFromList($scope.rolesAssignedUsers.lookUpRoleUsers, user);
                            } else {
                                removeUserFromList($scope.envRolesAssignedUsers[env].lookUpRoleUsers, user);
                            }
                        }, function (result) {
                            toastr.error(AppUtil.errorMsg(result), $translate.instant('Namespace.Role.DeleteFailed'));
                        });
                }
            };

            function removeUserFromList(list, user) {
                var index = 0;
                for (var i = 0; i < list.length; i++) {
                    if (list[i].userId === user) {
                        index = i;
                        break;
                    }
                }
                list.splice(index, 1);
            }



        }]);
