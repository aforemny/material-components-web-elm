import { MDCSliderFoundation } from "@material/slider/index";
import { strings } from "@material/slider/constants";

class MdcSlider extends HTMLElement {

  static get observedAttributes() {
    return ["value", "min", "max", "step", "disabled"];
  }

  get adapter() {
    return {
      hasClass: className => this.classList.contains(className),
      addClass: className => this.classList.add(className),
      removeClass: className => this.classList.remove(className),
      getAttribute: name => this.getAttribute(name),
      setAttribute: (name, value) => this.setAttribute(name, value),
      removeAttribute: name => this.removeAttribute(name),
      computeBoundingRect: () => this.getBoundingClientRect(),
      getTabIndex: () => this.tabIndex,
      registerInteractionHandler: (type, handler) => {
        this.addEventListener(type, handler);
      },
      deregisterInteractionHandler: (type, handler) => {
        this.removeEventListener(type, handler);
      },
      registerThumbContainerInteractionHandler: (type, handler) => {
        this.querySelector(".mdc-slider__thumb-container").addEventListener(type, handler);
      },
      deregisterThumbContainerInteractionHandler: (type, handler) => {
        this.querySelector(".mdc-slider__thumb-container")
          .removeEventListener(type, handler);
      },
      registerBodyInteractionHandler: (type, handler) => {
        document.body.addEventListener(type, handler);
      },
      deregisterBodyInteractionHandler: (type, handler) => {
        document.body.removeEventListener(type, handler);
      },
      registerResizeHandler: handler => {
        window.addEventListener('resize', handler);
      },
      deregisterResizeHandler: handler => {
        window.removeEventListener('resize', handler);
      },
      notifyInput: () => {
        this.dispatchEvent(new CustomEvent(strings.INPUT_EVENT, this));
      },
      notifyChange: () => {
        this.dispatchEvent(new CustomEvent(strings.CHANGE_EVENT, this));
      },
      setThumbContainerStyleProperty: (propertyName, value) => {
        this.querySelector(".mdc-slider__thumb-container")
          .style.setProperty(propertyName, value);
      },
      setTrackStyleProperty: (propertyName, value) => {
        this.querySelector(".mdc-slider__track").style.setProperty(propertyName, value);
      },
      setMarkerValue: value => {
        this.querySelector(".mdc-slider__pin-value-marker").innerText = value;
      },
      appendTrackMarkers: numMarkers => {
        const frag = document.createDocumentFragment();
        for (let i = 0; i < numMarkers; i++) {
          const marker = document.createElement("div");
          marker.classList.add("mdc-slider__track-marker");
          frag.appendChild(marker);
        }
        this.querySelector(".mdc-slider__track-marker-container").appendChild(frag);
      },
      removeTrackMarkers: () => {
        while (this.querySelector(".mdc-slider__track-marker-container").firstChild) {
          this.querySelector(".mdc-slider__track-marker-container")
            .removeChild(
              this.querySelector(".mdc-slider__track-marker-container").firstChild
            );
        }
      },
      setLastTrackMarkersStyleProperty: (propertyName, value) => {
        const lastTrackMarker =
          this.querySelector(strings.LAST_TRACK_MARKER_SELECTOR);
        lastTrackMarker.style.setProperty(propertyName, value);
      },
      isRTL: () => getComputedStyle(this).direction === 'rtl',
    };
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcFoundation = new MDCSliderFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.setMin(parseFloat(this.getAttribute("min")));
    this.mdcFoundation.setMax(parseFloat(this.getAttribute("max")));
    this.mdcFoundation.setValue(parseFloat(this.getAttribute("value")));
    this.mdcFoundation.setStep(parseFloat(this.getAttribute("step")));
    this.mdcFoundation.setDisabled(this.hasAttribute("disabled"));
    this.mdcFoundation.setupTrackMarker();
  }

  disconnectedCallback() {
    if (this.mdcFoundation) {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "value") {
      this.mdcFoundation.setValue(parseFloat(this.getAttribute("value")));
    } else if (name === "min") {
      this.mdcFoundation.setMin(parseFloat(this.getAttribute("min")));
    } else if (name === "max") {
      this.mdcFoundation.setMax(parseFloat(this.getAttribute("max")));
    } else if (name === "step") {
      this.mdcFoundation.setStep(parseFloat(this.getAttribute("step")));
    } else if (name === "disabled") {
      this.mdcFoundation.setDisabled(this.hasAttribute("disabled"));
    }
  }
};

customElements.define("mdc-slider", MdcSlider);
