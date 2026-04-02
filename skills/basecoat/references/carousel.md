# Carousel

**Not a component.** Use CSS scroll-snap:

```html
<div class="slider overflow-hidden">
  <div class="slides flex overflow-x-auto scroll-snap-x">
    <div class="slide shrink-0 w-full scroll-snap-start">1</div>
    <div class="slide shrink-0 w-full scroll-snap-start">2</div>
    <div class="slide shrink-0 w-full scroll-snap-start">3</div>
  </div>
</div>

<style>
  .slides {
    scroll-snap-type: x mandatory;
  }
  .slide {
    scroll-snap-align: start;
  }
  .slides::-webkit-scrollbar {
    display: none;
  }
</style>
```
