function plain_js_test() {
  return 'plain_js'
}
globalThis.from_assets ||= {}
globalThis.from_assets.plain_js_test = plain_js_test
plain_js_test()