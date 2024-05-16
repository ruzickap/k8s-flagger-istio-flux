module.exports = {
  title: 'Kubernetes + Flagger + Flux + Istio',
  description: 'Kubernetes + Flagger + Flux + Istio',
  base: '/k8s-flagger-istio-flux/',
  head: [
    ['link', { rel: 'icon', href: 'https://raw.githubusercontent.com/kubernetes/kubernetes/d9a58a39b69a0eaec5797e0f7a0f9472b4829ab0/logo/logo.svg' }]
  ],
  themeConfig: {
    displayAllHeaders: true,
    lastUpdated: true,
    repo: 'ruzickap/k8s-flagger-istio-flux',
    docsDir: 'docs',
    editLinks: true,
    logo: 'https://raw.githubusercontent.com/kubernetes/kubernetes/d9a58a39b69a0eaec5797e0f7a0f9472b4829ab0/logo/logo.svg',
    nav: [
      { text: 'Home', link: '/' },
      {
        text: 'Links',
        items: [
          { text: 'Flux', link: 'https://fluxcd.io' },
          { text: 'Flagger', link: 'https://flagger.app' }
        ]
      }
    ],
    sidebar: [
      '/',
      '/part-01/',
      '/part-02/',
      '/part-03/',
      '/part-04/',
      '/part-05/'
    ]
  },
  plugins: [
    ['@vuepress/medium-zoom'],
    ['@vuepress/back-to-top'],
    ['reading-progress'],
    ['smooth-scroll'],
    ['seo']
  ]
}
