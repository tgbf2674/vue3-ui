<template>
  <transition name="gulu-alert-fade">
    <div v-show="visible" class="gulu-alert" :class="[typeClass,center ? 'is-center' : '', 'is-' +effect]" role="alert">
      <Icon v-if="showIcon" class="gulu-alert__icon" :name="iconName" :class="isBigIcon"></Icon>
      <div class="gulu-alert__content">
        <span v-if="title || $slots.title" class="gulu-alert__title" :class="[isBoldTitle]">
          <slot name="title">{{ title }}</slot>
        </span>
        <p v-if="$slots.default || description" class="gulu-alert__description">
          <slot>{{ description }}</slot>
        </p>
        <Icon v-if="closable" class="gulu-alert__closebtn" :name="closeName"
              @click="close">{{ closeText }}
        </Icon>
        <span v-if="closeText!== ''" class="is-customed" @click="close">{{closeText}}</span>
      </div>
    </div>
  </transition>
</template>

<script lang="ts">
import {computed, defineComponent, PropType, ref} from 'vue';
import Icon from './Icon.vue';

const ALERT_TYPE_CLASSES_MAP = {
  success: 'icon-success',
  warning: 'icon-warning',
  error: 'icon-error',
  info: 'icon-info',
};

export default defineComponent({
  name: 'Alert',
  components: {Icon},
  props: {
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
      default: ''
    },
    type: {
      type: String as PropType<TagType>,
      default: 'info'
    },
    closable: {
      type: Boolean,
      default: true
    },
    closeText: {
      type: String,
      default: ''
    },
    showIcon: {
      type: Boolean
    },
    center: Boolean,
    effect: {
      type: String as PropType<AlertEffect>,
      default: 'light'
    }
  },
  emits: ['close'],
  setup(props, {emit, slots}) {
    const visible = ref(true);
    const typeClass = computed(() => {
      return `gulu-alert--${props.type}`;
    });
    const iconName = computed(() => ALERT_TYPE_CLASSES_MAP[props.type as keyof typeof ALERT_TYPE_CLASSES_MAP] || ALERT_TYPE_CLASSES_MAP['info']
    );
    const closeName = computed(()=>{
      if(props.closeText===''){
        return 'icon-close'
      }else {
        return null
      }
    })
    const isBigIcon = computed(() => props.description || slots.default ? 'is-big' : '');
    const isBoldTitle = computed(() => props.description || slots.default ? 'is-bold' : '');
    const close = (e: MouseEvent) => {
      visible.value = false;
      emit('close', e);
    };
    return {
      visible, typeClass, iconName, isBigIcon, isBoldTitle, close,closeName
    };
  }
});
</script>

<style lang="scss" scoped>
.gulu-alert {
  width: 100%;
  padding: 8px 16px;
  margin: 0;
  box-sizing: border-box;
  border-radius: 4px;
  position: relative;
  background-color: #ffffff;
  overflow: hidden;
  opacity: 1;
  display: flex;
  align-items: center;
  transition: opacity 0.2s;

  &.is-light {
    .gulu-alert__closebtn {
      &::v-deep .gulu-icon {
        fill: #909399;
      }
    }
  }

  &.is-dark {
    .gulu-alert__closebtn {
      &::v-deep .gulu-icon{
        fill: #ffffff;
      }
    }

    .gulu-alert__description {
      color: #ffffff;
    }
  }

  &.is-center {
    justify-content: center;
  }

  &.gulu-alert--success {
    &.is-light {
      background-color: #f0f9eb;
      color: #67c23a;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #67c23a;
        }
      }
      .gulu-alert__description {
        color: #67c23a;
      }
    }

    &.is-dark {
      background-color: #67c23a;
      color: #ffffff;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #ffffff;
        }
      }
    }
  }

  &.gulu-alert--warning {
    &.is-light {
      background-color: #fdf6ec;
      color: #e6a23c;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #e6a23c;
        }
      }
      .gulu-alert__description {
        color: #e6a23c;
      }
    }

    &.is-dark {
      background-color: #e6a23c;
      color: #ffffff;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #ffffff;
        }
      }
    }
  }

  &.gulu-alert--info {
    &.is-light {
      background-color: #f4f4f5;
      color: #909399;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #909399;
        }
      }
      .gulu-alert__description {
        color: #909399;
      }
    }

    &.is-dark {
      background-color: #909399;
      color: #ffffff;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #ffffff;
        }
      }
    }
  }

  &.gulu-alert--error {
    &.is-light {
      background-color: #fef0f0;
      color: #f56c6c;
      .gulu-alert__icon{
        &::v-deep .gulu-icon{
          fill: #f56c6c;
        }
      }
      .gulu-alert__description {
        color: #f56c6c;
        .gulu-alert__icon{
          &::v-deep .gulu-icon{
            fill: #ffffff;
          }
        }
      }
    }

    &.is-dark {
      background-color: #f56c6c;
      color: #ffffff;
    }
  }

  .gulu-alert__content {
    display: table-cell;
    padding: 0 8px;
  }

  .gulu-alert__icon {
    font-size: 16px;
    width: 16px;
    &.is-big {
      font-size: 24px;
      width: 24px;
    }
  }

  .gulu-alert__content {
    .gulu-alert__title {
      font-size: 13px;
      line-height: 18px;

      &.is-bold {
        font-weight: bold;
      }
    }

    & .gulu-alert__description {
      font-size: 12px;
      margin: 5px 0 0;
    }

    .gulu-alert__closebtn {
      font-size: 12px;
      opacity: 1;
      position: absolute;
      top: 12px;
      right: 15px;
      cursor: pointer;
    }
    .is-customed{
      font-style: normal;
      font-size: 12px;
      position: absolute;
      right: 15px;
      line-height: 24px;
      text-align: center;
      cursor: pointer;
    }
  }
}

.gulu-alert-fade-enter-from, .gulu-alert-fade-leave-active{
  opacity: 0;
}
</style>
