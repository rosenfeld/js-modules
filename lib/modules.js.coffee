prototypes = {}
@extendClass = (namespacedClass, methods)->
  declaredMethods = prototypes[namespacedClass] or= []
  declaredMethods.push methods
  modules = namespacedClass.split '.'
  className = modules.pop()
  module = extractModuleFrom modules
  module[className] or= class DynamicClass
    extend: extend
    constructor: ->
      @_className = namespacedClass
      extendClass this, declaredMethods.shift() while declaredMethods.length
      @initialize?.apply(this, arguments) # stack-overflow in IE8 if constructor is used instead of initialize

  extendClass = (_this, methods)->
    methods = methods.call(_this, _this) if methods instanceof Function
    extend DynamicClass.prototype, methods

extractModuleFrom = (modules, current = this)->
  return current unless modules.length
  current = current[modules.shift()] or= {}
  extractModuleFrom modules, current

extend = (target, obj)-> target[k] = v for k, v of obj; target
