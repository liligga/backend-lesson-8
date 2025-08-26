<script setup lang="ts">
import { ref, computed } from 'vue'

type Option = { id: number; text: string }
type Question = {
  id: number
  text: string
  options: Option[]
  correctId: number
}

const questions = ref<Question[]>([
  {
    id: 1,
    text: 'Что делает команда SELECT в SQL?',
    options: [
      { id: 1, text: 'Выбирает столбцы/данные из таблицы' },
      { id: 2, text: 'Удаляет таблицу' },
      { id: 3, text: 'Добавляет новую строку' },
      { id: 4, text: 'Обновляет существующий столбец' },
    ],
    correctId: 1,
  },
  {
    id: 2,
    text: 'Как выбрать все столбцы таблицы products?',
    options: [
      { id: 1, text: 'GET ALL COLUMNS FROM products' },
      { id: 2, text: 'SELECT products FROM *' },
      { id: 3, text: 'SELECT * FROM products' },
      { id: 4, text: 'FETCH * products' },
    ],
    correctId: 3,
  },
  {
    id: 3,
    text: 'Как отфильтровать строки по условию в SQL?',
    options: [
      { id: 1, text: 'Использовать предложение WHERE' },
      { id: 2, text: 'Использовать предложение ORDER BY' },
      { id: 3, text: 'Использовать предложение LIMIT' },
      { id: 4, text: 'Использовать предложение JOIN' },
    ],
    correctId: 1,
  },
  {
    id: 4,
    text: 'Как отсортировать результаты по возрастанию цены?',
    options: [
      { id: 1, text: 'ORDER BY price ASC' },
      { id: 2, text: 'ORDER BY price DESC' },
      { id: 3, text: 'SORT price UP' },
      { id: 4, text: 'GROUP BY price' },
    ],
    correctId: 1,
  },
  {
    id: 5,
    text: 'Как ограничить количество возвращаемых строк до 10?',
    options: [
      { id: 1, text: 'TOP 10' },
      { id: 2, text: 'LIMIT 10' },
      { id: 3, text: 'ROWCOUNT 10' },
      { id: 4, text: 'COUNT 10' },
    ],
    correctId: 2,
  },
  {
    id: 6,
    text: 'Какой тип соединения возвращает только совпадающие строки из обеих таблиц?',
    options: [
      { id: 1, text: 'LEFT JOIN' },
      { id: 2, text: 'RIGHT JOIN' },
      { id: 3, text: 'INNER JOIN' },
      { id: 4, text: 'FULL OUTER JOIN' },
    ],
    correctId: 3,
  },
  {
    id: 7,
    text: 'Какой тип соединения возвращает все строки левой таблицы и совпадения из правой?',
    options: [
      { id: 1, text: 'LEFT JOIN' },
      { id: 2, text: 'RIGHT JOIN' },
      { id: 3, text: 'INNER JOIN' },
      { id: 4, text: 'CROSS JOIN' },
    ],
    correctId: 1,
  },
  {
    id: 8,
    text: 'Как задать псевдоним столбца price как «цена»?',
    options: [
      { id: 1, text: 'SELECT price -> цена FROM products' },
      { id: 2, text: 'SELECT price AS цена FROM products' },
      { id: 3, text: 'SELECT price = цена FROM products' },
      { id: 4, text: 'SELECT price NAME цена FROM products' },
    ],
    correctId: 2,
  },
  {
    id: 9,
    text: 'Какая функция используется для подсчета количества строк?',
    options: [
      { id: 1, text: 'SUM()' },
      { id: 2, text: 'COUNT()' },
      { id: 3, text: 'AVG()' },
      { id: 4, text: 'MAX()' },
    ],
    correctId: 2,
  },
  {
    id: 10,
    text: 'Как найти максимальное значение в столбце price?',
    options: [
      { id: 1, text: 'SELECT MAX(price) FROM products' },
      { id: 2, text: 'SELECT MAXIMUM(price) FROM products' },
      { id: 3, text: 'SELECT TOP(price) FROM products' },
      { id: 4, text: 'SELECT HIGH(price) FROM products' },
    ],
    correctId: 1,
  },
  {
    id: 11,
    text: 'Какая команда используется для группировки данных?',
    options: [
      { id: 1, text: 'ORDER BY' },
      { id: 2, text: 'GROUP BY' },
      { id: 3, text: 'SORT BY' },
      { id: 4, text: 'CLUSTER BY' },
    ],
    correctId: 2,
  },
  {
    id: 12,
    text: 'Какая команда используется для добавления новой строки в таблицу?',
    options: [
      { id: 1, text: 'ADD' },
      { id: 2, text: 'INSERT' },
      { id: 3, text: 'CREATE' },
      { id: 4, text: 'APPEND' },
    ],
    correctId: 2,
  },
  {
    id: 13,
    text: 'Как обновить данные в существующей строке?',
    options: [
      { id: 1, text: 'MODIFY' },
      { id: 2, text: 'CHANGE' },
      { id: 3, text: 'UPDATE' },
      { id: 4, text: 'ALTER' },
    ],
    correctId: 3,
  },
  {
    id: 14,
    text: 'Какая команда используется для удаления строк из таблицы?',
    options: [
      { id: 1, text: 'REMOVE' },
      { id: 2, text: 'DELETE' },
      { id: 3, text: 'DROP' },
      { id: 4, text: 'CLEAR' },
    ],
    correctId: 2,
  },
  {
    id: 15,
    text: 'Что такое первичный ключ (PRIMARY KEY)?',
    options: [
      { id: 1, text: 'Столбец, который может содержать дубликаты' },
      { id: 2, text: 'Столбец, который уникально идентифицирует каждую строку' },
      { id: 3, text: 'Столбец, который может быть NULL' },
      { id: 4, text: 'Столбец, который содержит только числа' },
    ],
    correctId: 2,
  },
  {
    id: 16,
    text: 'Какой оператор используется для поиска значений в диапазоне?',
    options: [
      { id: 1, text: 'IN' },
      { id: 2, text: 'LIKE' },
      { id: 3, text: 'BETWEEN' },
      { id: 4, text: 'EXISTS' },
    ],
    correctId: 3,
  },
  {
    id: 17,
    text: 'Какая функция возвращает среднее значение?',
    options: [
      { id: 1, text: 'MEAN()' },
      { id: 2, text: 'AVERAGE()' },
      { id: 3, text: 'AVG()' },
      { id: 4, text: 'MID()' },
    ],
    correctId: 3,
  },
  {
    id: 18,
    text: 'Какое предложение используется для фильтрации групп?',
    options: [
      { id: 1, text: 'WHERE' },
      { id: 2, text: 'HAVING' },
      { id: 3, text: 'FILTER' },
      { id: 4, text: 'GROUP' },
    ],
    correctId: 2,
  },
  {
    id: 19,
    text: 'Какая команда создает новую таблицу?',
    options: [
      { id: 1, text: 'MAKE TABLE' },
      { id: 2, text: 'NEW TABLE' },
      { id: 3, text: 'CREATE TABLE' },
      { id: 4, text: 'BUILD TABLE' },
    ],
    correctId: 3,
  },
  {
    id: 20,
    text: 'Что означает NULL в SQL?',
    options: [
      { id: 1, text: 'Пустая строка' },
      { id: 2, text: 'Ноль' },
      { id: 3, text: 'Отсутствие значения' },
      { id: 4, text: 'Ложь' },
    ],
    correctId: 3,
  },
])

const currentIndex = ref(0)
const finished = ref(false)
// Индекс выбранного варианта на текущем шаге (по id варианта)
const answers = ref<(number | null)[]>(Array(questions.value.length).fill(null))

const currentQuestion = computed(() => questions.value[currentIndex.value])
const isAnswered = computed(() => answers.value[currentIndex.value] !== null)
const progressLabel = computed(() => `${currentIndex.value + 1} / ${questions.value.length}`)

function selectAnswer(optionId: number) {
  answers.value[currentIndex.value] = optionId
}

function next() {
  if (!isAnswered.value) return
  if (currentIndex.value < questions.value.length - 1) {
    currentIndex.value += 1
  } else {
    finished.value = true
  }
}

function restart() {
  currentIndex.value = 0
  finished.value = false
  answers.value = Array(questions.value.length).fill(null)
}
</script>

<template>
  <div p="4" max-w="800px" m="auto" flex="~ col gap-4">
    <h2 text="xl" font="semibold">Тест по SQL</h2>

    <div v-if="!finished" border="~ base rounded-md" p="4" flex="~ col gap-4">
      <div flex="~ row justify-between items-center">
        <span text="sm gray-600">Вопрос {{ progressLabel }}</span>
      </div>

      <div>
        <p text="lg" mb="2">{{ currentQuestion.text }}</p>
        <div flex="~ col gap-2">
          <button
            v-for="opt in currentQuestion.options"
            :key="opt.id"
            @click="selectAnswer(opt.id)"
            :class="[
              'text-left p-3 rounded-md border transition-colors',
              answers[currentIndex] === opt.id ? 'bg-blue-500 text-white border-blue-500' : 'hover:bg-gray-400/10 border-base'
            ]"
          >
            {{ opt.text }}
          </button>
        </div>
      </div>

      <div flex="~ row justify-end gap-2">
        <button
          btn
          :disabled="!isAnswered"
          :class="[!isAnswered ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer']"
          @click="next"
        >
          {{ currentIndex === questions.length - 1 ? 'Завершить' : 'Далее' }}
        </button>
      </div>
    </div>

    <div v-else border="~ base rounded-md" p="4" flex="~ col gap-4">
      <div flex="~ row justify-between items-center">
        <h3 text="lg" font="semibold">Результаты</h3>
        <button btn @click="restart">Пройти снова</button>
      </div>

      <div overflow="auto">
        <table w="full" border="~ base" rounded-md>
          <thead bg="gray-100">
            <tr>
              <th p="2" text="left">#</th>
              <th p="2" text="left">Вопрос</th>
              <th p="2" text="left">Ваш ответ</th>
              <th p="2" text="left">Правильный ответ</th>
              <th p="2" text="left">Статус</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(q, idx) in questions" :key="q.id" border="t base">
              <td p="2">{{ idx + 1 }}</td>
              <td p="2">{{ q.text }}</td>
              <td p="2">
                {{ q.options.find(o => o.id === answers[idx])?.text || '—' }}
              </td>
              <td p="2">
                {{ q.options.find(o => o.id === q.correctId)?.text }}
              </td>
              <td p="2">
                <span v-if="answers[idx] === q.correctId" text="green-600">✅</span>
                <span v-else text="red-600">❌</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
