angular.module('multiselect')

.controller('DropdownController', [
  '$scope'

  class DropdownController
    constructor: (
      @scope
    ) ->
      @scope.$watch 'isOpen', (isOpen, wasOpen) =>
        if isOpen
          @element.addClass('open')
        else
          @element.removeClass('open')

    init: (element) =>
      @element = element
      @element.addClass('ams-dropdown')

    toggle: (open) =>
      @scope.isOpen = if open? then !!open else !@scope.isOpen
])

.directive('amsDropdown', ->
  controller: 'DropdownController'
  link: (scope, element, attrs, dropdownCtrl) ->
    dropdownCtrl.init(element)
)

.directive('amsDropdownToggle', ->
  require: '?^amsDropdown'
  link: ($scope, element, attrs, dropdownCtrl) ->

    toggleDropdown = (event) ->
      event.preventDefault()
      unless element.hasClass('disabled') or attrs.disabled
        $scope.$apply ->
          dropdownCtrl.toggle()

    element.addClass('ams-dropdown-toggle')
    element.bind('click', toggleDropdown)

    $scope.$on '$destroy', ->
      element.unbind('click', toggleDropdown)
)

.directive('amsDropdownMenu', ->
  require: '?^amsDropdown'
  link: ($scope, element) ->
    element.addClass('ams-dropdown-menu')
)
