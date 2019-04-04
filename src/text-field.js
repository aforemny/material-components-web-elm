import { cssClasses, strings } from '@material/textfield/constants';
import { getMatchesProperty } from '@material/ripple/util';
import { MDCFloatingLabel, MDCFloatingLabelFoundation } from '@material/floating-label/index';
import { MDCLineRipple, MDCLineRippleFoundation } from '@material/line-ripple/index';
import { MDCNotchedOutline, MDCNotchedOutlineFoundation } from '@material/notched-outline/index';
import { MDCRipple, MDCRippleFoundation } from '@material/ripple/index';
import { MDCTextFieldFoundation } from "@material/textfield/index";
import { MDCTextFieldHelperText, MDCTextFieldHelperTextFoundation } from '@material/textfield/helper-text/index';
import { MDCTextFieldIcon, MDCTextFieldIconFoundation } from '@material/textfield/icon/index';

class MdcTextField extends HTMLElement {

  static get observedAttributes() {
    return ["value"];
    ;
  }

  get root_() {
    return this
  };

  get adapter() {
    return {
      addClass: className => this.classList.add(className),
      removeClass: className => this.classList.remove(className),
      hasClass: className => this.classList.contains(className),
      registerTextFieldInteractionHandler: (evtType, handler) =>
        this.addEventListener(evtType, handler),
      deregisterTextFieldInteractionHandler: (evtType, handler) =>
        this.removeEventListener(evtType, handler),
      registerValidationAttributeChangeHandler: handler => {
        const getAttributesList = mutationsList => mutationsList.map(mutation =>
          mutation.attributeName
        );
        const observer = new MutationObserver(mutationsList =>
          handler(getAttributesList(mutationsList))
        );
        const targetNode = this.querySelector(strings.INPUT_SELECTOR);
        const config = {attributes: true};
        observer.observe(targetNode, config);
        return observer;
      },
      deregisterValidationAttributeChangeHandler: observer => observer.disconnect(),
      isFocused: () => {
        return document.activeElement === this.querySelector(strings.INPUT_SELECTOR);
      },
      registerInputInteractionHandler: (evtType, handler) =>
        this.querySelector(strings.INPUT_SELECTOR).addEventListener(evtType, handler),
      deregisterInputInteractionHandler: (evtType, handler) =>
        this.querySelector(strings.INPUT_SELECTOR).removeEventListener(evtType, handler),
      getNativeInput: () => this.querySelector(strings.INPUT_SELECTOR),
      shakeLabel: shouldShake => this.mdcLabel.shake(shouldShake),
      floatLabel: shouldFloat => this.mdcLabel.float(shouldFloat),
      hasLabel: () => !!this.mdcLabel,
      getLabelWidth: () => this.mdcLabel ? this.mdcLabel.getWidth() : 0,
      activateLineRipple: () => {
        if (this.mdcLineRipple) {
          this.mdcLineRipple.activate();
        }
      },
      deactivateLineRipple: () => {
        if (this.mdcLineRipple) {
          this.mdcLineRipple.deactivate();
        }
      },
      setLineRippleTransformOrigin: normalizedX => {
        if (this.mdcLineRipple) {
          this.mdcLineRipple.setRippleCenter(normalizedX);
        }
      },
      notchOutline: labelWidth => this.mdcOutline.notch(labelWidth),
      closeOutline: () => this.mdcOutline.closeNotch(),
      hasOutline: () => !!this.mdcOutline,
      helperText: this.mdcHelperText ? this.mdcHelperText.foundation : undefined,
      leadingIcon: this.mdcLeadingIcon ? this.mdcLeadingIcon.foundation : undefined,
      trailingIcon: this.mdcTrailingIcon ? this.mdcTrailingIcon.foundation : undefined
    };
  }

  constructor() {
    super();
  }

  connectedCallback() {
    const inputElt = this.querySelector(strings.INPUT_SELECTOR);
    const labelElt = this.querySelector(strings.LABEL_SELECTOR);
    if (labelElt) {
      this.mdcLabel = new MDCFloatingLabel(labelElt);
    }
    const lineRippleElt = this.querySelector(strings.LINE_RIPPLE_SELECTOR);
    if (lineRippleElt) {
      this.mdcLineRipple = new MDCLineRipple(lineRippleElt);
    }
    const outlineElt = this.querySelector(strings.OUTLINE_SELECTOR);
    if (outlineElt) {
      this.mdcOutline = new MDCNotchedOutline(outlineElt);
    }
    if (inputElt.hasAttribute(strings.ARIA_CONTROLS)) {
      const helperTextElt = document.getElementById(
        inputElt.getAttribute(strings.ARIA_CONTROLS)
      );
      if (helperTextElt) {
        this.mdcHelperText = new MDCHelperText(helperTextElt);
      }
    }
    const iconElts = this.querySelectorAll(strings.ICON_SELECTOR);
    if (iconElts.length > 0) {
      if (iconElts.length > 1) {
        this.mdcLeadingIcon = new MDCTextFieldIcon(iconElts[0]);
        this.mdcTrailingIcon = new MDCTextFieldIcon(iconElts[1]);
      } else {
        if (this.classList.contains(cssClasses.WITH_LEADING_ICON)) {
          this.mdcLeadingIcon = new MDCTextFieldIcon(iconElts[0]);
        } else {
          this.mdcTrailingIcon = new MDCTextFieldIcon(iconElts[0]);
        }
      }
    }

    this.mdcRipple = null;
    if (!this.classList.contains(cssClasses.TEXTAREA) && !this.classList.contains(cssClasses.OUTLINED)) {
      const MATCHES = getMatchesProperty(HTMLElement.prototype);
      const adapter = Object.assign(
        MDCRipple.createAdapter(this),
        {
          isSurfaceActive: () =>
            this.querySelector(strings.INPUT_SELECTOR)[MATCHES](":active"),
          registerInteractionHandler: (type, handler) =>
            this.querySelector(strings.INPUT_SELECTOR).addEventListener(type, handler),
          deregisterInteractionHandler: (type, handler) =>
            this.querySelector(strings.INPUT_SELECTOR).removeEventListener(type, handler)
        }
      );
      this.mdcRipple = new MDCRipple(this, new MDCRippleFoundation(adapter));
    }

    this.mdcFoundation = new MDCTextFieldFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.setValue(this.getAttribute("value") || "");
  }

  disconnectedCallback() {
    if (typeof this.mdcFoundation !== "undefined") {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "value") {
      this.mdcFoundation.setValue(this.getAttribute("value") || "");
    }
  }
};

customElements.define("mdc-text-field", MdcTextField);
