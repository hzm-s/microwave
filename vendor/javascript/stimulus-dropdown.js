import{Controller as t}from"@hotwired/stimulus";import{useTransition as e}from"stimulus-use";class src_default extends t{connect(){e(this,{element:this.menuTarget})}toggle(){this.toggleTransition()}hide(t){this.element.contains(t.target)||this.menuTarget.classList.contains("hidden")||this.leave()}}src_default.targets=["menu"];export{src_default as default};

