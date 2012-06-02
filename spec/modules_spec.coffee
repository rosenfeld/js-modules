extendClass = require('../lib/modules.js').extendClass

initializeThis = initializeArgs = funcArg = thisWas = bindedThis = nonBindedThis = null
extendClass 'namespace.ClassName', (self)->
  thisWas = this
  funcArg = self
  initialize: ->
    initializeThis = this
    initializeArgs = arguments
    setTimeout @nonBinded, 0
    setTimeout @binded, 0
  nonBinded: -> nonBindedThis = this
  binded: => bindedThis = this

extendClass 'namespace.ClassName',
  extended: -> true

extendClass 'namespace.ClassName', ->
  local = 'local'
  getLocal: => "#{local} - #{@extended()}"

instance = new namespace.ClassName('arg1', 2)

describe 'extendClass', ->
  it 'creates namespace.ClassName', ->
    expect(namespace.ClassName instanceof Function).toBeTruthy()
  it 'correctly handles instanceof', ->
    expect(instance instanceof namespace.ClassName).toBeTruthy()
  it 'allows object-like extending', ->
    expect(instance.extended()).toBe true
  it 'calls initialize on new', ->
    expect(initializeThis).toBe instance
  it 'passes the instance as the extending function argment', ->
    expect(funcArg).toBe instance
  it 'calls the extending function with this set to the instance', ->
    expect(thisWas).toBe instance
  it 'calls initialize with the correct arguments', ->
    expect(initializeArgs[0]).toBe 'arg1'
    expect(initializeArgs[1]).toBe 2
  it 'binds correctly when used with the function-style', ->
    waitsFor -> bindedThis
    runs ->
      expect(nonBindedThis).not.toBe instance
      expect(bindedThis).toBe instance
  it 'allows the usage of local variables', ->
    expect(instance.getLocal).not.toBeUndefined()
    expect(instance.local).toBeUndefined()
    expect(instance.getLocal()).toBe 'local - true'
  it 'provides an extend method', ->
    a = {a: 1, b: 2}
    b = instance.extend a, a: 3, c: 4
    expect(a is b).toBeTruthy()
    expect(a).toEqual a: 3, b: 2, c:4
  it 'allows classes without initialize method definition', ->
    extendClass 'AnotherClass', someProperty: 'property value'
    another = new AnotherClass
    expect(another.someProperty).toBe 'property value'
