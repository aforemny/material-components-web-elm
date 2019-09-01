import { getClassName, setClassName } from "./utils";
import { matches } from "@material/dom/ponyfill";
import { MDCChipFoundation } from "@material/chips/index";
import { MDCRipple, MDCRippleFoundation } from "@material/ripple/index";

const INTERACTION_EVENTS = [ "click", "keydown" ];

class MdcChip extends HTMLElement {

  static get observedAttributes() {
    return ["selected"];
  }

  constructor() {
    super();
    this.className_ = "";
  }

  connectedCallback() {
    this.root_ = this;
    this.foundation_ = new MDCChipFoundation(this.getAdapter_());
    this.foundation_.init();
    this.foundation_.setSelected(this.hasAttribute("selected"));

    this.ripple_ = new MDCRipple(this, new MDCRippleFoundation({
      ...MDCRipple.createAdapter(this),
      computeBoundingRect: () => this.foundation_.getDimensions(),
    }));

    this.handleInteraction_ = event => this.foundation_.handleInteraction(event);
    this.handleTransitionEnd_ = event => this.foundation_.handleTransitionEnd(event);
    this.handleTrailingIconInteraction_ = event =>
      this.foundation_.handleTrailingIconInteraction(event);

    INTERACTION_EVENTS.forEach(eventType =>
      this.addEventListener(eventType, this.handleInteraction_)
    );
    this.addEventListener("transitionend", this.handleTransitionEnd_);

    if (this.trailingIcon_) {
      INTERACTION_EVENTS.forEach(eventType =>
        this.trailingIcon_.addEventListener(eventType, handleTrailingIconInteraction_)
      );
    }
  }

  disconnectedCallback() {
    this.foundation_.destroy();
    this.ripple_.destroy();

    INTERACTION_EVENTS.forEach(eventType =>
      this.removeEventListener(eventType, this.handleInteraction_)
    );
    this.removeEventListener("transitionend", this.handleTransitionEnd_);

    if (this.trailingIcon_) {
      INTERACTION_EVENTS.forEach(eventType =>
        this.trailingIcon_.removeEventListener(eventType, handleTrailingIconInteraction_)
      );
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.foundation_) return;
    if (name === "selected") {
      this.foundation_.setSelected(this.hasAttribute("selected"));
    }
  };

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  get leadingIcon_() {
    return this.querySelector(MDCChipFoundation.strings.LEADING_ICON_SELECTOR);
  }

  get trailingIcon_() {
    return this.querySelector(MDCChipFoundation.strings.TRAILING_ICON_SELECTOR);
  }

  get checkmark_() {
    return this.querySelector(MDCChipFoundation.strings.CHECKMARK_SELECTOR);
  }

  getAdapter_() {
    return {
      addClass: className => this.classList.add(className),
      addClassToLeadingIcon: className => {
        if (this.leadingIcon_) {
          this.leadingIcon_.classList.add(className);
        }
      },
      eventTargetHasClass: (target, className) =>
        target ? target.classList.contains(className) : false,
      getCheckmarkBoundingClientRect: () =>
        this.checkmark_ ? this.checkmark_.getBoundingClientRect() : null,
      getComputedStyleValue: propertyName =>
        window.getComputedStyle(this).getPropertyValue(propertyName),
      getRootBoundingClientRect: () => this.getBoundingClientRect(),
      hasClass: className => this.classList.contains(className),
      hasLeadingIcon: () => !!this.leadingIcon_,
      notifyInteraction: () => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.INTERACTION_EVENT,
          { detail: { chipId: this.id },
            bubbles: true,
          },
        ))
      },
      notifyRemoval: () => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.REMOVAL_EVENT,
          { detail: {
              chipId: this.id,
              root: this,
            },
            bubbles: true,
          },
        ))
      },
      notifySelection: selected => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.SELECTION_EVENT,
          {
            detail: {
              chipId: this.id,
              selected,
            },
            bubbles: true,
          },
        ))
      },
      notifyTrailingIconInteraction: () => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.TRAILING_ICON_INTERACTION_EVENT,
          {
            detail: { chipId: this.id, },
            bubbles: true,
          },
        ))
      },
      removeClass: className => this.classList.remove(className),
      removeClassFromLeadingIcon: className => {
        if (this.leadingIcon_) {
          this.leadingIcon_.classList.remove(className);
        }
      },
      setStyleProperty: (propertyName, value) =>
        this.style.setProperty(propertyName, value),
    };
  }
};

customElements.define("mdc-chip", MdcChip);
