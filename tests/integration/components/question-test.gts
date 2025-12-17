// @ts-nocheck
import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import type { TestContext } from '@ember/test-helpers';
import Question from 'ember-latest/components/question';

interface QuestionTestContext extends TestContext {
  question: { id: string; text: string; options: unknown[] };
  selectedOptions: string[];
  noop: () => void;
}

module('Integration | Component | question', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (
    this: QuestionTestContext,
    assert
  ) {
    this.setProperties({
      question: {
        id: 'q1',
        text: 'Sample question',
        options: [],
      },
      selectedOptions: [],
      noop() {},
    });

    await render(<template>
      <Question
        @question={{this.question}}
        @selectedOptions={{this.selectedOptions}}
        @onUpdateSelection={{this.noop}}
        @currentQuestionNumber={{1}}
        @totalQuestions={{1}}
      />
    </template>);

    assert.dom('h2').includesText('Sample question');
  });
});
