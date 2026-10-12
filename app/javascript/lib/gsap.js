// GSAP is loaded as a classic script (vendor/assets/javascripts/gsap.min.js)
// before the import map. This module re-exports it so controllers can use
// `import { gsap } from "gsap"`.
export const gsap = window.gsap
export default gsap
