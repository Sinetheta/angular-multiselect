angular.module('demo', ['multiselect'])

.controller('demoCtrl', function ($scope) {
  $scope.awesomeThings = [
    'AngularJS',
    'Coffeescript',
    'Gulp'
  ];
  $scope.myThing = undefined;
})

.controller('disabledCtrl', function ($scope) {
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
