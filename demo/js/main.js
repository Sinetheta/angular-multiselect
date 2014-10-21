angular.module('demo', ['multiselect'])

.controller('demoSimpleCtrl', function ($scope) {
  $scope.awesomeThings = [
    'AngularJS',
    'Coffeescript',
    'Gulp'
  ];
})

.controller('demoDisabledCtrl', function ($scope) {
  $scope.terribleThings = [
    'EmberJS',
    'TypeScript',
    'Make'
  ];
  $scope.terribleThingsCopy = angular.copy($scope.terribleThings);

  $scope.$watch('disabledThings', function(disabledThings) {
    _.forEach(disabledThings, function(disabledThing) {
      _.forEach($scope.terribleThings, function(terribleThing) {
        if (terribleThing.label === disabledThing.label) {
          terribleThing.disabled = true
        }
      })
    });
  }, true)
})

.controller('demoTemplateCtrl', function ($scope) {
  $scope.customTemplate = 'custom-template.html'
  $scope.awesomeThings = [
    'AngularJS',
    'Coffeescript',
    'Gulp'
  ];
})

.controller('dynamicCtrl', function ($scope) {
  $scope.awesomeThings = [
    'AngularJS',
    'Coffeescript',
    'Gulp'
  ];

  // so that the options list transformation doesn't mutate the input list
  $scope.$watch('simpleList', function(simpleList) {
    $scope.simpleListCopy = angular.copy(simpleList)
  }, true)
})
