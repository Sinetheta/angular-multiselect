angular.module('multiselect')

.service('DropdownService', [
  '$document'

  class DropdownService
    constructor: (@$document) ->

    open: (dropdownScope) =>
      @openScope.isOpen = false  if @openScope and @openScope isnt dropdownScope
      @openScope = dropdownScope

    close: (dropdownScope) =>
      if @openScope is dropdownScope
        @openScope = null
])

.controller('DropdownController', [
  '$scope'
  'DropdownService'

  class DropdownController
    constructor: (
      @scope
      @DropdownService
    ) ->
      @scope.getToggleElement = => @element

      @scope.focusToggleElement = =>
        @element[0].focus()

      @scope.$watch 'isOpen', (isOpen, wasOpen) =>
        if isOpen
          @element.addClass('open')
          @scope.focusToggleElement()
          @DropdownService.open(@scope)
        else
          @element.removeClass('open')
          @DropdownService.close(@scope)

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
