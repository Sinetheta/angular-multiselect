angular.module('multiselect', ['ams-templates'])
.directive('multiselect', [
  '$compile'
  '$http'
  '$templateCache'
(
  $compile
  $http
  $templateCache
) ->
  restrict: 'EA'
  scope:
    model: '=?'
    options: '=?'
    selected: '=?'
    title: '@'
  templateUrl: 'multiselect.html'
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

    $scope.showSelections = ->
      $scope.model.length

    $scope.updateModel = ->
      $scope.model = $scope.options.filter (option) ->
        option.selected
      $scope.selected = $scope.model.map (option) ->
        option.value

    $scope.$watch 'options' , (options) ->
      (options or []).forEach (option, index) ->
        unless option instanceof Choice
          $scope.options[index] = new Choice(option)
  ]
  link: ($scope, element, attrs) ->
    attrs.title ?= 'Select'
    element.addClass('multiselect')

    loadTemplate = (template) ->
      $http.get(template, { cache: $templateCache })
      .success (templateContent) ->
        element.replaceWith($compile(templateContent)($scope))

    attrs.$observe 'templateUrl', (url) ->
      if url then loadTemplate(url)
])
