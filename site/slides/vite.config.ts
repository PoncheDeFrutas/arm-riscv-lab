import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
  publicDir: 'public',
  resolve: {
    alias: {
      '@assets': resolve(__dirname, 'assets')
    }
  },
  server: {
    fs: {
      allow: ['..']
    }
  }
})
