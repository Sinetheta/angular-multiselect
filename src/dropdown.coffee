angular.module('multiselect')

.service('DropdownService', [
  '$document'

  class DropdownService
    constructor: (@$document) ->

    open: (dropdownScope) =>
      unless @openScope
        @$document.bind('click', @onClick)
        @$document.bind('keydown', @onKeydown)
      @openScope.isOpen = false  if @openScope and @openScope isnt dropdownScope
      @openScope = dropdownScope

    close: (dropdownScope) =>
      if @openScope is dropdownScope
        @openScope = null
        @$document.unbind('click', @onClick)
        @$document.unbind('keydown', @onKeydown)

    onClick: (event) =>
      # This method may still be called during the same mouse event that
      # unbound this event handler. So check @openScope before proceeding.
      return unless @openScope

      # Ignore clicks inside the dropdown
      toggleElement = @openScope.getToggleElement()
      return if toggleElement and toggleElement[0].contains(event.target)

      @closeDropdown()

    onKeydown: (evt) =>
      if evt.which is 27 # Esc
        @openScope.focusToggleElement()
        @closeDropdown()

    closeDropdown: (event) =>
      @openScope.$apply =>
        @openScope.isOpen = false
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
