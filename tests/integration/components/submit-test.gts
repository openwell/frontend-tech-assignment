// @ts-nocheck
import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import type { TestContext } from '@ember/test-helpers';
import Submit from 'ember-latest/components/submit';

interface SubmitTestContext extends TestContext {
  quizData: {
    title: string;
    questions: Array<{
      id: string;
      text: string;
      options: Array<{ id: string; text: string }>;
    }>;
  };
  selectedAnswers: Record<string, string[]>;
  onSubmit: () => void;
}

module('Integration | Component | submit', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (
    this: SubmitTestContext,
    assert
  ) {
    this.setProperties({
      quizData: {
        title: 'Sample quiz',
        questions: [
          {
            id: 'q1',
            text: 'Question 1',
            options: [{ id: 'o1', text: 'Option 1' }],
          },
        ],
      },
      selectedAnswers: { q1: ['o1'] },
      onSubmit() {},
    });

    await render(<template>
      <Submit
        @quizData={{this.quizData}}
        @selectedAnswers={{this.selectedAnswers}}
        @onSubmit={{this.onSubmit}}
      />
    </template>);

    assert.dom().includesText('Question 1');
  });
});
