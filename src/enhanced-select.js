import * as menuSurfaceConstants from "@material/menu-surface/constants";
import { getClassName, setClassName } from "./utils";
import { MDCMenu } from "@material/menu/index";
import { MDCRipple, MDCRippleFoundation } from "@material/ripple/index";
import { MDCSelect, MDCSelectFoundation } from "@material/select/index";

class MdcEnhancedSelect extends HTMLElement {

  constructor() {
    super();
    this.className_ = "";
    this.menuOpened_ = false;
    this.handleChange_ = this.handleChange.bind(this);
    this.handleFocus_ = this.handleFocus.bind(this);
    this.handleBlur_ = this.handleBlur.bind(this);
    this.handleClick_ = this.handleClick.bind(this);
    this.handleKeydown_ = this.handleKeydown.bind(this);
    this.handleMenuOpened_ = this.handleMenuOpened.bind(this);
    this.handleMenuClosed_ = this.handleMenuClosed.bind(this);
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  get root_() {
    return this;
  }

  get adapter() {
    return {
      getValue: () => "",
      setValue: value => {},
      openMenu: () => {
        if (this.menu_ && !this.menu_.open) {
          this.menu_.open = true;
          this.menuOpened_ = true;
          this.selectedText_.setAttribute('aria-expanded', 'true');
        }
      },
      closeMenu: () => {
        if (this.menu_ && this.menu_.open) {
          this.menu_.open = false;
        }
      },
      isMenuOpen: () => this.menu_ && this.menuOpened_,
      setSelectedIndex: index => {},
      setDisabled: isDisabled => {
        this.selectedText_.setAttribute('tabindex', isDisabled ? '-1' : '0');
        this.selectedText_.setAttribute('aria-disabled', isDisabled.toString());
      },
      checkValidity: () => !this.hasAttribute("invalid"),
      setValid: isValid => {},
      addClass: className => this.classList.add(className),
      removeClass: className => this.classList.remove(className),
      hasClass: className => this.classList.contains(className),
      setRippleCenter: normalizedX => this.lineRipple_ &&
        this.lineRipple_.setRippleCenter(normalizedX),
      activateBottomLine: () => this.lineRipple_ && this.lineRipple_.activate(),
      deactivateBottomLine: () => this.lineRipple_ && this.lineRipple_.deactivate(),
      notifyChange: value => {},
      hasOutline: () => !!this.outline_,
      notchOutline: labelWidth => {
        if (this.outline_) {
          this.outline_.notch(labelWidth);
        }
      },
      closeOutline: () => {
        if (this.outline_) {
          this.outline_.closeNotch();
        }
      },
      floatLabel: shouldFloat => {
        if (this.label_) {
          this.label_.float(shouldFloat);
        }
      },
      getLabelWidth: () => {
        return this.label_ ? this.label_.getWidth() : 0;
      }
    };
  }

  get foundationMap() {
    return {
      leadingIcon: this.leadingIcon_ ? this.leadingIcon_.foundation_ : undefined,
      helperText: this.helperText_ ? this.helperText_.foundation_ : undefined,
    };
  }

  layout() {
    this.foundation_.layout();
  }

  connectedCallback() {
    this.foundation_ = new MDCSelectFoundation(this.adapter, this.foundationMap);
    this.foundation_.init();
    this.selectedText_ = this.querySelector(
      MDCSelectFoundation.strings.SELECTED_TEXT_SELECTOR
    );

    const isDisabled = this.classList.contains(MDCSelectFoundation.cssClasses.DISABLED);
    this.selectedText_.setAttribute("tabindex", isDisabled ? "-1" : "0");

    this.menuElement_ = this.querySelector(MDCSelectFoundation.strings.MENU_SELECTOR);
    this.menu_ = new MDCMenu(this.menuElement_);
    // Note: `hoistMenuToBody` confuses VirtualDOM.
    this.style.overflow = "visible";
    this.menu_.setFixedPosition(true);
    this.menu_.setAnchorCorner(menuSurfaceConstants.Corner.BOTTOM_START);
    this.menu_.wrapFocus = false;

    const labelElement = this.querySelector(MDCSelectFoundation.strings.LABEL_SELECTOR);
    const lineRippleElement =
      this.querySelector(MDCSelectFoundation.strings.LINE_RIPPLE_SELECTOR);
    const outlineElement =
      this.querySelector(MDCSelectFoundation.strings.OUTLINE_SELECTOR);
    if (this.selectedText_.hasAttribute(MDCSelectFoundation.strings.ARIA_CONTROLS)) {
      const helperTextElement = document.getElementById(
        this.selectedText_.getAttribute(MDCSelectFoundation.strings.ARIA_CONTROLS)
      );
    }

    if (!this.classList.contains(MDCSelectFoundation.cssClasses.OUTLINED)) {
      this.ripple = this.initRipple();
    }

    this.selectedText_.addEventListener("change", this.handleChange_);
    this.selectedText_.addEventListener("focus", this.handleFocus_);
    this.selectedText_.addEventListener("blur", this.handleBlur_);
    ["mousedown", "touchstart"].forEach(evtType =>
      this.selectedText_.addEventListener(evtType, this.handleClick_)
    );
    this.selectedText_.addEventListener("keydown", this.handleKeydown_);
    this.menu_.listen(menuSurfaceConstants.strings.CLOSED_EVENT, this.handleMenuClosed_);
    this.menu_.listen(menuSurfaceConstants.strings.OPENED_EVENT, this.handleMenuOpened_);
    this.foundation_.handleChange(false);
  }

  initRipple() {
    const adapter = Object.assign(MDCRipple.createAdapter(this), {
      registerInteractionHandler: (type, handler) =>
        this.selectedText_.addEventListener(type, handler),
      deregisterInteractionHandler: (type, handler) =>
        this.selectedText_.removeEventListener(type, handler)
    });
    const foundation = new MDCRippleFoundation(adapter);
    return new MDCRipple(this, foundation);
  }

  disconnectedCallback() {
    if (typeof this.foundation_ !== "undefined") {
      this.foundation_.destroy();
      delete this.foundation_;
    }
  }

  handleChange(event) {
    this.foundation_.handleChange(event);
  }

  handleFocus(event) {
    this.foundation_.handleFocus(event);
  }

  handleBlur(event) {
    this.foundation_.handleBlur(event);
  }

  handleClick(event) {
    this.selectedText_.focus();
    this.foundation_.handleClick(this.getNormalizedXCoordinate_(event));
  }

  getNormalizedXCoordinate_(event) {
    const targetClientRect = event.target.getBoundingClientRect();
    const xCoordinate = event.clientX;
    return xCoordinate - targetClientRect.left;
  }

  handleKeydown(event) {
    this.foundation_.handleKeydown(event);
  }

  handleMenuOpened(event) {
  }

  handleMenuClosed(event) {
    this.menuOpened_ = false;
    this.selectedText_.removeAttribute('aria-expanded');
    if (document.activeElement !== this.selectedText_) {
      this.foundation_.handleBlur();
    }
  }

};

customElements.define("mdc-enhanced-select", MdcEnhancedSelect);
