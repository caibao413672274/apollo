directive_module.directive('showtextmodal', showTextModalDirective);

function showTextModalDirective($translate, toastr) {
    return {
        restrict: 'E',
        templateUrl: '../../views/component/show-text-modal.html',
        transclude: true,
        replace: true,
        scope: {
            text: '='
        },
        link: function (scope) {
            scope.$watch('text', init);

            function init() {
                scope.jsonObject = undefined;
                if (isJsonText(scope.text)) {
                    scope.jsonObject = JSON.parse(scope.text);
                }
            }

            function isJsonText(text) {
                try {
                    return typeof JSON.parse(text) === "object";
                } catch (e) {
                    return false;
                }
            }
            scope.doCopy = function(text) {
                try {
                    document.getElementById('selectCopy').value=text;
                    document.getElementById('selectCopy').select(); //选中赋值过的input
                    var tag = document.execCommand("Copy"); //执行复制
                   if(tag)
                    toastr.success($translate.instant('Component.ShowText.CopySuccess'));
                   else {
                       toastr.error(tag, $translate.instant('Component.ShowText.CopyFailed'));
                   }
                }catch (e) {
                    toastr.error(e.message, $translate.instant('Component.ShowText.CopyFailed'));
                }
            };
        }
    }
}


