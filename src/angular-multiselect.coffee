angular.module('multiselect', ['ams-templates'])
.directive('multiselect', ->
  restrict: 'EA'
  scope:
    model: '=?'
    options: '=?'
    selected: '=?'
  templateUrl: (element, attr) ->
    attr.templateUrl or 'multiselect.html'
  controller: [
    '$scope'
    'Choice'
  (
      $scope
      Choice
  ) ->
    $scope.model ?= []
    $scope.options ?= []
    $scope.selected ?= []

    $scope.options.forEach (option, index) ->
      $scope.options[index] = new Choice(option)

    $scope.showSelections = ->
      $scope.model.length

    $scope.updateModel = ->
      $scope.model = $scope.options.filter (option) ->
        option.selected
      $scope.selected = $scope.model.map (option) ->
        option.value
  ]
  link: ($scope, element) ->
    element.addClass('multiselect')
)
