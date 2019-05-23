Autocomplete = (args) ->
    $.extend this,
        config: $.extend(true, {}, defaults, args)
        results: []
        searchTerm: ''
        displayed: false
        selected: false
        typingTimer: null
        resultIndex: -1
        specialKeys:
            9: 'tab'
            27: 'esc'
            13: 'enter'
            38: 'up'
            40: 'down'
            37: 'left'
            39: 'right'
        classes:
            wrapper: 'autocomplete'
            input: 'autocomplete__input'
            results: 'autocomplete__results'
            list: 'autocomplete__list'
            item: 'autocomplete__list__item'
            highlighted: 'autocomplete__list__item--highlighted'
            disabled: 'autocomplete__list__item--disabled'
            empty: 'autocomplete__list__item--empty'
            searchTerm: 'autocomplete__list__item__search-term'
            loading: 'is-loading'
            visible: 'is-visible'
    # make sure threshold isn't lower than 1
    @config.threshold < 1 and (@config.threshold = 1)
    # if 'value' template is undefined, use 'item' template
    !@config.templates.value and (@config.templates.value = @config.templates.item)
    # if custom fetch/onItem is undefined, use default functions
    !@config.fetch and (@config.fetch = @defaultFetch)
    !@config.onItem and (@config.onItem = $.proxy(@defaultOnItem, this))
    # extend default classes
    for key of @classes
        if @config.extraClasses[key]
            @classes[key] = @classes[key].concat(' ', @config.extraClasses[key])
    # define templates for all elements
    @templates =
        $wrapper: $('<div>').addClass(@classes.wrapper)
        $results: $('<div>').addClass(@classes.results)
        $list: $('<div>').addClass(@classes.list)
        $item: $('<div>').addClass(@classes.item).html(@config.templates.item).attr('data-value', @config.templates.value)
        $empty: $('<div>').addClass(@classes.item.concat(' ', @classes.empty, ' ', @classes.disabled)).html(@config.templates.empty[drupalSettings.path.currentLanguage])
    @$el = $(@config.el)
    # turn off native browser autocomplete feature unless it's textarea
    !@$el.is('textarea') and @$el.attr('autocomplete', 'off')
    @init()
    return

'use strict'
defaults =
    el: '.js-autocomplete'
    threshold: 2
    limit: 5
    forceSelection: false
    debounceTime: 200
    triggerChar: null
    templates:
        item: '<strong>{{text}}</strong>'
        value: '{{text}}'
        empty:
            en: 'No matches found'
            fa: 'جستجو نتیجه ای در بر نداشت'
    extraClasses: {}
    fetch: undefined
    onItem: undefined
    searchTermHighlight: true

Autocomplete::init = ->
    @wrapEl()
    @listen()
    return

# -------------------------------------------------------------------------
# Subscribe to Events
# -------------------------------------------------------------------------

Autocomplete::listen = ->
    _this = this
    touchmoved = false
    itemSelector = '.' + @classes.item.replace(RegExp(' ', 'g'), '.')
    @$el.on('keyup click', $.proxy(@processTyping, this)).on('keydown', $.proxy(@processSpecialKey, this)).on 'blur', (e) ->
        if _this.config.forceSelection
            e.target.value != _this.searchTerm and _this.$el.val(_this.searchTerm)
            !_this.selected and _this.$el.val('')
        #_this.clearResults();
        return
    # 'blur' fires before 'click' so we have to use 'mousedown'
    @$results.on('mousedown touchend', itemSelector, (e) ->
        if !touchmoved
            e.preventDefault()
            e.stopPropagation()
            _this.selectResult()
        return
    ).on('mouseenter touchstart', itemSelector, ->
        _this.resultIndex = $(this).index()
        _this.highlightResult()
        touchmoved = false
        return
    ).on 'touchmove', itemSelector, ->
        touchmoved = true
        return
    return

# -------------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------------

Autocomplete::wrapEl = ->
    @$el.addClass(@classes.input).wrap(@templates.$wrapper).after @templates.$results.append(@templates.$list)
    @$wrapper = @$el.closest('.' + @classes.wrapper.replace(RegExp(' ', 'g'), '.'))
    @$results = $('.' + @classes.results.replace(RegExp(' ', 'g'), '.'), @$wrapper)
    @$list = $('.' + @classes.list.replace(RegExp(' ', 'g'), '.'), @$wrapper)
    return

Autocomplete::showResults = ->
    @populateResults()
    if @results.length > 0 and @config.searchTermHighlight
# highlight search term
        @$items.highlight $.trim(@searchTerm).split(' '),
            element: 'span'
            className: @classes.searchTerm
    @$wrapper.addClass @classes.visible
    @displayed = true
    @resultIndex = -1
    # highlight first item if forceSelection
    if @config.forceSelection
        @changeIndex('down') and @highlightResult()
    return

Autocomplete::hideResults = ->
    @$wrapper.removeClass @classes.visible
    @displayed = false
    return

Autocomplete::populateResults = ->
    @processTemplate()
    @$list.html @$items
    return

Autocomplete::processTemplate = ->
    len = @results.length
    @$items = $()
    if !len and !!@config.templates.empty
        $.merge @$items, @templates.$empty.html(@config.templates.empty[drupalSettings.path.currentLanguage])
    else
        i = 0
        while i < len
            $.merge @$items, @renderTemplate(@templates.$item, @results[i])
            i++
    return

Autocomplete::renderTemplate = ($item, obj) ->
    template = $item[0].outerHTML
    for key of obj
        template = template.replace(new RegExp('{{' + key + '}}', 'gm'), obj[key])
    $item = $(template)
    obj.disabled and obj.disabled == true and $item.addClass(@classes.disabled)
    $item

Autocomplete::highlightResult = ->
    $currentItem = @$items.eq(@resultIndex)
    # unless disabled, highlight result by adding class
    @$items.removeClass @classes.highlighted
    if !$currentItem.hasClass(@classes.disabled)
        $currentItem.addClass @classes.highlighted
    return

Autocomplete::selectResult = ->
    $item = @$items.eq(@resultIndex)
    if !$item.hasClass(@classes.disabled)
        @selected = true
        @config.onItem $item
        # pass actual DOM element to onItem()
        @searchTerm = @$el.val()
        @clearResults()
    return

Autocomplete::clearResults = ->
    @results = []
    @$list.html null
    @resultIndex = -1
    @hideResults()
    return

Autocomplete::callFetch = ->
    _this = this
    limit = @config.limit
    @config.fetch @searchTerm, (results) ->
        if !!results
            _this.results = if limit > 0 then results.slice(0, limit) else results
            if (!!_this.config.templates.empty[drupalSettings.path.currentLanguage] or results.length > 0) and _this.$el.is(':focus')
                _this.showResults()
            else
                _this.clearResults()
        _this.$wrapper.removeClass _this.classes.loading
        return
    return

Autocomplete::getTriggeredValue = (e) ->
    referenceIndex = e.target.selectionStart - 1
    fullValue = e.target.value
    lastSpace = fullValue.lastIndexOf(' ', referenceIndex)
    nextSpace = fullValue.indexOf(' ', referenceIndex)
    lastNewline = fullValue.lastIndexOf('\n', referenceIndex)
    nextNewline = fullValue.indexOf('\n', referenceIndex)
    startIndex = undefined
    endIndex = undefined
    triggeredValue = undefined
    startIndex = if lastSpace > lastNewline then lastSpace else lastNewline
    if nextSpace > -1 and nextNewline > -1
        endIndex = if nextSpace < nextNewline then nextSpace else nextNewline
    else if nextSpace == -1 and nextNewline > -1
        endIndex = nextNewline
    else if nextSpace > -1 and nextNewline == -1
        endIndex = nextSpace
    triggeredValue = fullValue.substring(startIndex + 1, endIndex)
    if triggeredValue.charAt(0) == @config.triggerChar then triggeredValue else ''

Autocomplete::processTyping = (e) ->
    currentInputVal = if @config.triggerChar then @getTriggeredValue(e) else $.trim(e.target.value)
    if @searchTerm != currentInputVal
        @searchTerm = currentInputVal
        @selected = false
        if @searchTerm.length and @searchTerm.length >= @config.threshold
            @debounceSearch()
        else
            @clearResults()
    return

Autocomplete::debounceSearch = ->
    clearTimeout @typingTimer
    @typingTimer = setTimeout($.proxy(@processSearch, this), @config.debounceTime)
    return

Autocomplete::processSearch = ->
    @$wrapper.addClass @classes.loading
    @callFetch()
    return

Autocomplete::currentItemDisabled = ->
    @$items.eq(@resultIndex).hasClass @classes.disabled

Autocomplete::allItemsDisabled = ->
    !@$items.not('.' + @classes.disabled).length

Autocomplete::increaseIndex = ->
    @resultIndex++
    @resultIndex == @results.length and (@resultIndex = 0)
    return

Autocomplete::decreaseIndex = ->
    @resultIndex <= 0 and (@resultIndex = @results.length)
    @resultIndex--
    return

Autocomplete::changeIndex = (direction) ->
    resultsLength = @results.length
    tmpIndex = @resultIndex
    i = 0
    if resultsLength and !@allItemsDisabled()
        switch direction
            when 'up'
                @decreaseIndex()
                while @currentItemDisabled() and i < resultsLength
                    @decreaseIndex()
                    i++
            when 'down'
                @increaseIndex()
                while @currentItemDisabled() and i < resultsLength
                    @increaseIndex()
                    i++
    @resultIndex != tmpIndex

Autocomplete::processSpecialKey = (e) ->
    keyName = @specialKeys[e.keyCode]
    indexChanged = false
    anyResultHighlighted = @resultIndex > -1
    anyResultsAvailable = !!@results.length
    clearTimeout @typingTimer
    if @displayed
        switch keyName
            when 'up', 'down'
                if anyResultsAvailable
                    e.preventDefault()
                    indexChanged = @changeIndex(keyName)
            when 'left', 'right'
                if anyResultHighlighted
                    e.preventDefault()
                    indexChanged = @changeIndex(if keyName == 'left' then 'up' else 'down')
            when 'enter', 'tab'
                if anyResultHighlighted
                    e.preventDefault()
                    @selectResult()
            when 'esc'
                e.preventDefault()
                @config.forceSelection and @$el.val('')
                @clearResults()
    indexChanged and @highlightResult()
    return

Autocomplete::defaultFetch = (searchTerm, callback) ->
    results = [
        {text: 'Jon'}
        {
            text: 'Bon'
            disabled: true
        }
        {text: 'Jovi'}
    ]
    callback $.grep(results, (result) ->
        result.text.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1
    )
    return

Autocomplete::defaultOnItem = (item) ->
    $(@config.el).val $(item).data('value')
    return

# -------------------------------------------------------------------------
# From jquery.highlight.js:
# -------------------------------------------------------------------------
$.extend highlight: (node, re, nodeName, className) ->
    if node.nodeType == 3
        match = node.data.match(re)
        if match
            highlight = document.createElement(nodeName or 'span')
            highlight.className = className or 'highlight'
            wordNode = node.splitText(match.index)
            wordNode.splitText match[0].length
            wordClone = wordNode.cloneNode(true)
            highlight.appendChild wordClone
            wordNode.parentNode.replaceChild highlight, wordNode
            return 1
#skip added node in parent
    else if node.nodeType == 1 and node.childNodes and !/(script|style)/i.test(node.tagName) and !(node.tagName == nodeName.toUpperCase() and node.className == className)
        i = 0
        while i < node.childNodes.length
            i += $.highlight(node.childNodes[i], re, nodeName, className)
            i++
    0

$.fn.highlight = (words, options) ->
    settings =
        className: 'highlight'
        element: 'span'
        caseSensitive: false
        wordsOnly: false
    $.extend settings, options
    if words.constructor == String
        words = [words]
    words = $.grep(words, (word, i) ->
        word != ''
    )
    words = $.map(words, (word, i) ->
        word.replace /[-[\]{}()*+?.,\\^$|#\s]/g, '\\$&'
    )
    if words.length == 0
        return this
    flag = if settings.caseSensitive then '' else 'i'
    pattern = '(' + words.join('|') + ')'
    if settings.wordsOnly
        pattern = '\\b' + pattern + '\\b'
    re = new RegExp(pattern, flag)
    @each ->
        $.highlight this, re, settings.element, settings.className
        return

$(document).ready ->
    lang = ''
    if drupalSettings.path.currentLanguage != 'en'
        lang = drupalSettings.path.currentLanguage + '/'
    new Autocomplete(
        el: '#block-religous-search input'
        threshold: 2
        limit: 5
        forceSelection: true
        templates:
            item: '<div class="search-result-item">' + '<div class="image">{{field_image}}</div>' + '<div class="description">' + '<h2 class="title-text">{{title}}</h2>' + '<div class="body">{{body}}</div>' + '</div>' + '</div>'
            value: '{{title}}'
        fetch: (searchTerm, cb) ->
            results = []
            data = []
            $.ajax(url: drupalSettings.path.baseUrl + lang + 'searchSuggestions/?title=' + searchTerm).done (data) ->
                searchFields = [
                    'title'
                    'body'
                ]
                foundMatch = undefined
                i = undefined
                j = undefined
                k = undefined
                searchTerm = $.trim(searchTerm.toLowerCase()).split(' ')
                i = 0
                while i < data.length
                    foundMatch = false
                    j = 0
                    while j < searchTerm.length
                        k = 0
                        while k < searchFields.length
                            foundMatch = foundMatch or data[i][searchFields[k]].toLowerCase().indexOf(searchTerm[j]) != -1
                            k++
                        j++
                    foundMatch and results.push(data[i])
                    i++
                cb results
                return
            return
    )
    return

# ---
# generated by js2coffee 2.2.0
