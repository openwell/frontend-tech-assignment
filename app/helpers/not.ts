import { helper } from '@ember/component/helper';

export function not([value]: [string | number | boolean]): boolean {
  return !value;
}

export default helper(not);
