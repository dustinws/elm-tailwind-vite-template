import { defineConfig } from 'vite'
import { plugin as elmPlugin } from 'vite-plugin-elm'

const isProd = process.env.NODE_ENV === 'production';

export default defineConfig({
  plugins: [
    elmPlugin({
      debug: !isProd,
      optimize: isProd,
    }),
  ]
});
