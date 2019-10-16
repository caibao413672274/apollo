setting_module.controller('AppRightController',
                          ['$scope', '$location',
                           'AppService', 'AppUtil',
                              AppRightController]);

function AppRightController($scope, $location,
                           AppService, AppUtil) {

    var params = AppUtil.parseParams($location.$$url);

    $scope.pageContext = {
        appId: params.appid
    };

    init();

    function init() {


    }

}
