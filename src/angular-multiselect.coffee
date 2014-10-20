angular.module('multiselect', ['ams-templates'])
.directive('multiselect', ->
  restrict: 'EA'
  scope:
    model: '='
    options: '='
  templateUrl: (element, attr) ->
    attr.templateUrl or 'multiselect.html'
  controller: [
    '$scope'
    'Choice'
  (
      $scope
      Choice
  ) ->
    model = $scope.model or []

    options = $scope.options or []
    options.forEach (option, index) ->
      options[index] = new Choice(option)

    $scope.options = options

    $scope.model = model

    $scope.showSelections = ->
      $scope.model.length

    $scope.updateModel = ->
      replaceContents model, options.filter (option) ->
        option.selected
  ]
  link: ($scope, element) ->
    element.addClass('multiselect')
)

replaceContents = (array, newContents) ->
  array.splice(0, array.length, newContents...)
