function camelize(e){return e.replace(/(?:[_-])([a-z0-9])/g,((e,t)=>t.toUpperCase()))}function capitalize(e){return e.charAt(0).toUpperCase()+e.slice(1)}function dasherize(e){return e.replace(/([A-Z])/g,((e,t)=>`-${t.toLowerCase()}`))}function readInheritableStaticArrayValues(e,t){const r=getAncestorsForConstructor(e);return Array.from(r.reduce(((e,r)=>{getOwnStaticArrayValues(r,t).forEach((t=>e.add(t)));return e}),new Set))}function readInheritableStaticObjectPairs(e,t){const r=getAncestorsForConstructor(e);return r.reduce(((e,r)=>{e.push(...getOwnStaticObjectPairs(r,t));return e}),[])}function getAncestorsForConstructor(e){const t=[];while(e){t.push(e);e=Object.getPrototypeOf(e)}return t.reverse()}function getOwnStaticArrayValues(e,t){const r=e[t];return Array.isArray(r)?r:[]}function getOwnStaticObjectPairs(e,t){const r=e[t];return r?Object.keys(r).map((e=>[e,r[e]])):[]}(()=>{function extendWithReflect(e){function extended(){return Reflect.construct(e,arguments,new.target)}extended.prototype=Object.create(e.prototype,{constructor:{value:extended}});Reflect.setPrototypeOf(extended,e);return extended}function testReflectExtension(){const a=function(){this.a.call(this)};const e=extendWithReflect(a);e.prototype.a=function(){};return new e}try{testReflectExtension();return extendWithReflect}catch(e){return e=>class extended extends e{}}})();function ClassPropertiesBlessing(e){const t=readInheritableStaticArrayValues(e,"classes");return t.reduce(((e,t)=>Object.assign(e,propertiesForClassDefinition(t))),{})}function propertiesForClassDefinition(e){return{[`${e}Class`]:{get(){const{classes:t}=this;if(t.has(e))return t.get(e);{const r=t.getAttributeName(e);throw new Error(`Missing attribute "${r}"`)}}},[`${e}Classes`]:{get(){return this.classes.getAll(e)}},[`has${capitalize(e)}Class`]:{get(){return this.classes.has(e)}}}}function TargetPropertiesBlessing(e){const t=readInheritableStaticArrayValues(e,"targets");return t.reduce(((e,t)=>Object.assign(e,propertiesForTargetDefinition(t))),{})}function propertiesForTargetDefinition(e){return{[`${e}Target`]:{get(){const t=this.targets.find(e);if(t)return t;throw new Error(`Missing target element "${e}" for "${this.identifier}" controller`)}},[`${e}Targets`]:{get(){return this.targets.findAll(e)}},[`has${capitalize(e)}Target`]:{get(){return this.targets.has(e)}}}}function ValuePropertiesBlessing(e){const t=readInheritableStaticObjectPairs(e,"values");const r={valueDescriptorMap:{get(){return t.reduce(((e,t)=>{const r=parseValueDefinitionPair(t);const n=this.data.getAttributeNameForKey(r.key);return Object.assign(e,{[n]:r})}),{})}}};return t.reduce(((e,t)=>Object.assign(e,propertiesForValueDefinitionPair(t))),r)}function propertiesForValueDefinitionPair(e){const t=parseValueDefinitionPair(e);const{key:r,name:n,reader:s,writer:i}=t;return{[n]:{get(){const e=this.data.get(r);return null!==e?s(e):t.defaultValue},set(e){void 0===e?this.data.delete(r):this.data.set(r,i(e))}},[`has${capitalize(n)}`]:{get(){return this.data.has(r)||t.hasCustomDefaultValue}}}}function parseValueDefinitionPair([e,t]){return valueDescriptorForTokenAndTypeDefinition(e,t)}function parseValueTypeConstant(e){switch(e){case Array:return"array";case Boolean:return"boolean";case Number:return"number";case Object:return"object";case String:return"string"}}function parseValueTypeDefault(e){switch(typeof e){case"boolean":return"boolean";case"number":return"number";case"string":return"string"}return Array.isArray(e)?"array":"[object Object]"===Object.prototype.toString.call(e)?"object":void 0}function parseValueTypeObject(e){const t=parseValueTypeConstant(e.type);if(t){const r=parseValueTypeDefault(e.default);if(t!==r)throw new Error(`Type "${t}" must match the type of the default value. Given default value: "${e.default}" as "${r}"`);return t}}function parseValueTypeDefinition(e){const t=parseValueTypeObject(e);const r=parseValueTypeDefault(e);const n=parseValueTypeConstant(e);const s=t||r||n;if(s)return s;throw new Error(`Unknown value type "${e}"`)}function defaultValueForDefinition(t){const r=parseValueTypeConstant(t);if(r)return e[r];const n=t.default;return void 0!==n?n:t}function valueDescriptorForTokenAndTypeDefinition(e,n){const s=`${dasherize(e)}-value`;const i=parseValueTypeDefinition(n);return{type:i,key:s,name:camelize(s),get defaultValue(){return defaultValueForDefinition(n)},get hasCustomDefaultValue(){return void 0!==parseValueTypeDefault(n)},reader:t[i],writer:r[i]||r.default}}const e={get array(){return[]},boolean:false,number:0,get object(){return{}},string:""};const t={array(e){const t=JSON.parse(e);if(!Array.isArray(t))throw new TypeError("Expected array");return t},boolean(e){return!("0"==e||"false"==e)},number(e){return Number(e)},object(e){const t=JSON.parse(e);if(null===t||"object"!=typeof t||Array.isArray(t))throw new TypeError("Expected object");return t},string(e){return e}};const r={default:writeString,array:writeJSON,object:writeJSON};function writeJSON(e){return JSON.stringify(e)}function writeString(e){return`${e}`}class Controller{constructor(e){this.context=e}static get shouldLoad(){return true}get application(){return this.context.application}get scope(){return this.context.scope}get element(){return this.scope.element}get identifier(){return this.scope.identifier}get targets(){return this.scope.targets}get classes(){return this.scope.classes}get data(){return this.scope.data}initialize(){}connect(){}disconnect(){}dispatch(e,{target:t=this.element,detail:r={},prefix:n=this.identifier,bubbles:s=true,cancelable:i=true}={}){const o=n?`${n}:${e}`:e;const c=new CustomEvent(o,{detail:r,bubbles:s,cancelable:i});t.dispatchEvent(c);return c}}Controller.blessings=[ClassPropertiesBlessing,TargetPropertiesBlessing,ValuePropertiesBlessing];Controller.targets=[];Controller.values={};class src_default extends Controller{connect(){this.class=this.hasHiddenClass?this.hiddenClass:"hidden"}toggle(){this.itemTargets.forEach((e=>{e.classList.toggle(this.class)}))}show(){this.itemTargets.forEach((e=>{e.classList.remove(this.class)}))}hide(){this.itemTargets.forEach((e=>{e.classList.add(this.class)}))}}src_default.targets=["item"];src_default.classes=["hidden"];export{src_default as default};
