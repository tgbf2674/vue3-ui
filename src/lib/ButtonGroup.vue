<template>
  <div class="gulu-buttonGroup">
    <slot />
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, PropType, reactive, toRef, provide } from "vue";

export default defineComponent({
  name: 'ButtonGroup',
  props: {
    size: {
      type: String as PropType<ButtonSize>,
      default: 'normal'
    },
    level: {
      type: String as PropType<ButtonLevel>,
      default: 'normal'
    }
  },
  setup(props) {
    provide(
      'buttonGroupContext',
      reactive({
        size: toRef(props, 'size'),
        level: toRef(props, 'level')
      })
    )
    return {
    }
  }
})
</script>

<style lang="scss">
.gulu-buttonGroup > .gulu-button {
  & + .gulu-button {
    margin-left: 0;
  }
  &:first-child {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
  }
  &:last-child {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
  }
   &:not(:first-child):not(:last-child) {
      border-radius: 0;
    }
    &:not(:last-child) {
      margin-right: -1px;
    }
}
</style>
