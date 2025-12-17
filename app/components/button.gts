import Component from '@glimmer/component';
import { on } from '@ember/modifier';

const BASE_CLASSES =
  'inline-flex items-center justify-center rounded-lg font-medium transition-all focus:outline-none focus:ring-2 focus:ring-offset-2 cursor-pointer';

const VARIANTS = {
  primary:
    'bg-indigo-600 text-white hover:bg-indigo-700 hover:shadow-lg focus:ring-indigo-500',
  secondary:
    'bg-gray-200 text-gray-700 hover:bg-gray-300 hover:shadow-md focus:ring-indigo-500',
  muted: 'bg-gray-200 text-gray-400',
  danger: 'text-red-600 hover:text-red-700 hover:bg-red-50 focus:ring-red-500',
  ghost: 'text-gray-700 hover:bg-gray-100 focus:ring-indigo-500',
};

const SIZES = {
  sm: 'px-3 py-1.5 text-sm',
  md: 'px-4 py-2 text-sm',
  lg: 'px-6 py-2',
  xl: 'px-8 py-3 text-base',
};

type ButtonVariant = keyof typeof VARIANTS;
type ButtonSize = keyof typeof SIZES;

export interface ButtonSignature {
  Args: {
    type?: 'button' | 'submit' | 'reset';
    disabled?: boolean;
    variant?: ButtonVariant;
    size?: ButtonSize;
    fullWidth?: boolean;
    class?: string;
    onClick?: (event: MouseEvent) => void;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLButtonElement;
}

export default class Button extends Component<ButtonSignature> {
  get type(): 'button' | 'submit' | 'reset' {
    return this.args.type ?? 'button';
  }

  get isDisabled(): boolean {
    return Boolean(this.args.disabled);
  }

  get variantClass(): string {
    const variant: ButtonVariant = this.args.variant ?? 'primary';
    return VARIANTS[variant];
  }

  get sizeClass(): string {
    const size: ButtonSize = this.args.size ?? 'md';
    return SIZES[size];
  }

  get widthClass(): string {
    return this.args.fullWidth ? 'w-full' : '';
  }

  get classNames(): string {
    let classes = [
      BASE_CLASSES,
      this.variantClass,
      this.sizeClass,
      this.widthClass,
      this.isDisabled ? 'opacity-60 cursor-not-allowed' : '',
      this.args.class ?? '',
    ];

    return classes.filter(Boolean).join(' ');
  }

  handleClick = (event: Event): void => {
    this.args.onClick?.(event as MouseEvent);
  };

  <template>
    <button
      ...attributes
      type={{this.type}}
      disabled={{this.isDisabled}}
      aria-disabled={{this.isDisabled}}
      {{on "click" this.handleClick}}
      class={{this.classNames}}
    >
      {{yield}}
    </button>
  </template>
}
