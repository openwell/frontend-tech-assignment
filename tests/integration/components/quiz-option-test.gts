import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import type { TestContext } from '@ember/test-helpers';
import QuizOption from 'ember-latest/components/quiz-option';

interface QuizOptionTestContext extends TestContext {
  option: { id: string; text: string };
}

module('Integration | Component | quiz-option', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (this: QuizOptionTestContext, assert) {
    const option = { id: '1', text: 'Option 1' };

    await render(<template><QuizOption @option={{option}} /></template>);

    assert.dom('li').includesText('Option 1');
  });
});
