import * as ponyfill from "@material/dom/ponyfill";
import { cssClasses, strings } from '@material/textfield/constants';
import { getClassName, setClassName } from "./utils";
import { MDCFloatingLabel, MDCFloatingLabelFoundation } from '@material/floating-label/index';
import { MDCLineRipple, MDCLineRippleFoundation } from '@material/line-ripple/index';
import { MDCNotchedOutline, MDCNotchedOutlineFoundation } from '@material/notched-outline/index';
import { MDCRipple, MDCRippleFoundation } from '@material/ripple/index';
import { MDCTextFieldCharacterCounter, MDCTextFieldCharacterCounterFoundation } from "@material/textfield/character-counter/index";
import { MDCTextFieldFoundation } from "@material/textfield/index";
import { MDCTextFieldHelperText, MDCTextFieldHelperTextFoundation } from '@material/textfield/helper-text/index';
import { MDCTextFieldIcon, MDCTextFieldIconFoundation } from '@material/textfield/icon/index';

class MdcTextField extends HTMLElement {

  static get observedAttributes() {
    return ["value"];
  }

  constructor() {
    super();
    this.root_ = this;
    this.className_ = "";
    this.foundation_;
    this.helperText_;
    this.input_;
    this.label_;
    this.leadingIcon_;
    this.lineRipple_;
    this.outline_;
    this.ripple_;
    this.trailingIcon_;
  }

  connectedCallback() {
    this.input_ = this.querySelector(strings.INPUT_SELECTOR);

    const labelElement = this.querySelector(strings.LABEL_SELECTOR);
    if (labelElement) {
      this.label_ = new MDCFloatingLabel(labelElement);
    }

    const lineRippleElement = this.querySelector(strings.LINE_RIPPLE_SELECTOR);
    if (lineRippleElement) {
      this.lineRipple_ = new MDCLineRipple(lineRippleElement);
    }

    const outlineElement = this.querySelector(strings.OUTLINE_SELECTOR);
    if (outlineElement) {
      this.outline_ = new MDCNotchedOutline(outlineElement);
    }

    const helperTextStrings = MDCTextFieldHelperTextFoundation.strings;
    const nextElementSibling = this.root_.nextElementSibling;
    const hasHelperLine = (nextElementSibling && nextElementSibling.classList.contains(cssClasses.HELPER_LINE));
    const helperTextElement = hasHelperLine && nextElementSibling.querySelector(helperTextStrings.ROOT_SELECTOR);
    if (helperTextElement) {
      this.helperText_ = new MDCTextFieldHelperText(helperTextElement);
    }

    const characterCounterStrings = MDCTextFieldCharacterCounterFoundation.strings;
    let characterCounterElement = this.root_.querySelector(characterCounterStrings.ROOT_SELECTOR);
    if (!characterCounterElement && hasHelperLine) {
      characterCounterElement = nextElementSibling.querySelector(characterCounterStrings.ROOT_SELECTOR);
    }
    if (characterCounterElement) {
      this.characterCounter_ = new MDCTextFieldCharacterCounter(characterCounterElement);
    }

    const iconElements = this.querySelectorAll(strings.ICON_SELECTOR);
    if (iconElements.length > 0) {
      if (iconElements.length > 1) {
        this.leadingIcon_ = new MDCTextFieldIcon(iconElements[0]);
        this.trailingIcon_ = new MDCTextFieldIcon(iconElements[1]);
      } else {
        if (this.classList.contains(cssClasses.WITH_LEADING_ICON)) {
          this.leadingIcon_ = new MDCTextFieldIcon(iconElements[0]);
        } else {
          this.trailingIcon_ = new MDCTextFieldIcon(iconElements[0]);
        }
      }
    }

    this.ripple_ = null;
    const isTextArea = this.classList.contains(cssClasses.TEXTAREA);
    const isOutlined = this.classList.contains(cssClasses.OUTLINED);
    if (!isTextArea && !isOutlined) {
      this.ripple_ = new MDCRipple(this, new MDCRippleFoundation({
        ...MDCRipple.createAdapter(this),
        isSurfaceActive: () => ponyfill.matches(this.input_, ":active"),
        registerInteractionHandler: (eventType, handler) =>
          this.input_.addEventListener(eventType, handler),
        deregisterInteractionHandler: (eventType, handler) =>
          this.input_.removeEventListener(eventType, handler),
      }));
    }

    this.foundation_ = new MDCTextFieldFoundation(
      this.getAdapter_(),
      this.getFoundationMap_()
    );
    this.foundation_.init();
    this.foundation_.setValue(this.getAttribute("value") || "");
  }

  disconnectedCallback() {
    if (this.foundation_) {
      this.foundation_.destroy();
    }
    if (this.helperText_) {
      this.helperText_.destroy();
    }
    if (this.label_) {
      this.label_.destroy();
    }
    if (this.leadingIcon_) {
      this.leadingIcon_.destroy();
    }
    if (this.lineRipple_) {
      this.lineRipple_.destroy();
    }
    if (this.outline_) {
      this.outline_.destroy();
    }
    if (this.ripple_) {
      this.ripple_.destroy();
    }
    if (this.trailingIcon_) {
      this.trailingIcon_.destroy();
    }
    if (this.characterCounter_) {
      this.characterCounter_.destroy();
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.foundation_) return;
    if (name === "value") {
      this.foundation_.setValue(this.getAttribute("value") || "");
    }
  }

  getAdapter_() {
    return Object.assign(
      {
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
      },
      this.getInputAdapterMethods_(),
      this.getLabelAdapterMethods_(),
      this.getLineRippleAdapterMethods_(),
      this.getOutlineAdapterMethods_(),
    );
  }

  getInputAdapterMethods_() {
    return {
      registerInputInteractionHandler: (evtType, handler) =>
        this.querySelector(strings.INPUT_SELECTOR).addEventListener(evtType, handler),
      deregisterInputInteractionHandler: (evtType, handler) =>
        this.querySelector(strings.INPUT_SELECTOR).removeEventListener(evtType, handler),
      getNativeInput: () => this.querySelector(strings.INPUT_SELECTOR),
    };
  }

  getLabelAdapterMethods_() {
    return {
      shakeLabel: shouldShake => this.label_.shake(shouldShake),
      floatLabel: shouldFloat => this.label_.float(shouldFloat),
      hasLabel: () => !!this.label_,
      getLabelWidth: () => this.label_ ? this.label_.getWidth() : 0,
    };
  }

  getLineRippleAdapterMethods_() {
    return {
      activateLineRipple: () => {
        if (this.lineRipple_) {
          this.lineRipple_.activate();
        }
      },
      deactivateLineRipple: () => {
        if (this.lineRipple_) {
          this.lineRipple_.deactivate();
        }
      },
      setLineRippleTransformOrigin: normalizedX => {
        if (this.lineRipple_) {
          this.lineRipple_.setRippleCenter(normalizedX);
        }
      },
    };
  }

  getOutlineAdapterMethods_() {
    return {
      notchOutline: labelWidth => this.outline_.notch(labelWidth),
      closeOutline: () => this.outline_.closeNotch(),
      hasOutline: () => !!this.outline_,
    };
  }

  getFoundationMap_() {
    return {
      helperText: this.helperText_ ? this.helperText_.foundation : undefined,
      characterCounter: this.characterCounter_ ? this.characterCounter_.foundation : undefined,
      leadingIcon: this.leadingIcon_ ? this.leadingIcon_.foundation : undefined,
      trailingIcon: this.trailingIcon_ ? this.trailingIcon_.foundation : undefined
    };
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }
};

customElements.define("mdc-text-field", MdcTextField);
