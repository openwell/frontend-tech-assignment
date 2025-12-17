import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';

interface IndexSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Index"}}

  <div class="text-center p-12 h-screen bg-blue-50 rounded-lg m-5">
    <h1 class="text-3xl font-bold mb-4">Welcome to the Quiz App!</h1>
    <p class="text-gray-600 mb-6">Test your knowledge with our fun quiz. Are you
      ready to begin?</p>
    <LinkTo
      @route="quiz"
      class="inline-block px-5 py-2 bg-indigo-600 text-white hover:bg-indigo-700 no-underline rounded text-xl"
    >Start Quiz</LinkTo>
  </div>
</template> satisfies TOC<IndexSignature>;
