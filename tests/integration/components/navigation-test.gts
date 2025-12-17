import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import Navigation from 'ember-latest/components/navigation';

module('Integration | Component | navigation', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const onPrevious = () => {};
    const onNext = () => {};

    await render(
      <template>
        <Navigation
          @hasSelection={{true}}
          @onPrevious={{onPrevious}}
          @onNext={{onNext}}
        />
      </template>
    );

    assert.dom('button').exists();
  });
});
