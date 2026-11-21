<script setup lang="ts">
import fanLogo from './assets/brand/quievent-fan.svg'
import wordmarkLogo from './assets/brand/quievent-wordmark.svg'
import heroImage from './assets/product-images/quievent-studio-hero.png'
import airflowImage from './assets/product-images/quievent-airflow-detail.png'
import laptopImage from './assets/product-images/quievent-with-laptop.png'
const email = ref('')
const status = ref<'idle' | 'loading' | 'success' | 'error'>('idle')
const message = ref('')
useHead({ title: 'QUIEVENT — Strong cooling. Quietly.', meta: [{ name: 'description', content: 'Meet QUIEVENT, a powerful laptop cooling pad designed to bring more cooling and less noise to your workspace.' }] })
async function reserve() {
  status.value = 'loading'
  try {
    await $fetch('/api/preorder', { method: 'POST', body: { email: email.value } })
    status.value = 'success'
  } catch (error: any) {
    message.value = error?.data?.statusMessage || 'Something went wrong. Please try again.'
    status.value = 'error'
  }
}
</script>

<template>
  <div class="site" id="top">
    <header class="header wrap">
      <a class="brand" href="#top" aria-label="Quievent home"><img :src="fanLogo" alt=""><img class="brand-word" :src="wordmarkLogo" alt="QUIEVENT"></a>
      <a class="nav-link" href="#reserve">Join the interest list</a>
    </header>
    <main>
      <section class="hero wrap">
        <p class="eyebrow"><span class="cross" aria-hidden="true"></span> SWISS MADE COOLING</p>
        <h1>Strong cooling.<br><span>Quietly.</span></h1>
        <p class="lead">Meet QUIEVENT. Powerful airflow for your laptop, designed to be heard as little as possible.</p>
        <a class="button" href="#reserve">Register your interest</a>
        <p class="hero-note">EARLY PROTOTYPE · NO PAYMENT REQUIRED</p>
      </section>
      <figure class="photo hero-photo"><img :src="heroImage" alt="The QUIEVENT cooling pad prototype with its fan grilles and logo"><figcaption>THE QUIEVENT PROTOTYPE <span>STUDIO-EDITED IMAGE</span></figcaption></figure>
      <section class="story wrap">
        <p class="eyebrow"><span class="line"></span> POWER MEETS PEACE</p>
        <h2>Feel the airflow.<br><span>Keep your focus.</span></h2>
        <p>More cooling shouldn’t mean more noise. QUIEVENT is built around a simple idea: move plenty of air while keeping your workspace calm.</p>
      </section>
      <figure class="photo detail-photo"><img loading="lazy" :src="airflowImage" alt="Close view of the QUIEVENT prototype’s cooling fans and adjustable controller"><figcaption>AIRFLOW, WITH INTENTION <span>STUDIO-EDITED IMAGE</span></figcaption></figure>
      <section class="story wrap">
        <div class="benefit-icon" aria-hidden="true"><svg viewBox="0 0 64 64" fill="none"><path d="M11 26h9l11-9v30l-11-9h-9V26Z"/><path d="m43 25 10 14m0-14L43 39"/></svg></div>
        <p class="eyebrow"><span class="line"></span> LESS FAN NOISE</p>
        <h2>A quieter laptop.<br><span>A calmer workspace.</span></h2>
        <div class="result-highlight"><strong>1,000+ <span>RPM lower</span></strong><p>Internal fan speed in an early prototype test</p></div>
        <p>When QUIEVENT helps carry away heat, your laptop's internal fans may not need to work as hard. That can mean less fan noise while you work, create or play.</p>
        <p class="observation">Observed in one test. Results depend on the laptop, workload and environment; further testing is underway.</p>
      </section>
      <figure class="photo laptop-photo"><img loading="lazy" :src="laptopImage" alt="A laptop resting on the QUIEVENT cooling pad prototype"><figcaption>MADE FOR YOUR WORKSPACE <span>STUDIO-EDITED IMAGE</span></figcaption></figure>
      <section class="story wrap">
        <div class="benefit-icon" aria-hidden="true"><svg viewBox="0 0 64 64" fill="none"><path d="M12 47a22 22 0 1 1 40 0"/><path d="m32 38 11-13M22 47h20"/><circle cx="32" cy="38" r="3"/></svg></div>
        <p class="eyebrow"><span class="line"></span> SUSTAINED PERFORMANCE</p>
        <h2>More cooling.<br><span>More performance.</span></h2>
        <div class="result-highlight"><strong>Less throttling.<br><span>More sustained speed.</span></strong><p>Designed to help your laptop keep performing</p></div>
        <p>Heat can make a laptop slow down to protect itself. QUIEVENT is designed to help reduce thermal throttling, so your laptop can maintain more of its speed during demanding work.</p>
        <p class="observation">For fanless laptops such as MacBook Air, the goal is thermal support rather than reducing internal fan noise. Compatibility and performance are still being tested.</p>
      </section>
      <section class="prototype wrap"><div class="prototype-inner"><p class="eyebrow"><span class="cross" aria-hidden="true"></span> MADE TO EVOLVE</p><h2>Built from an idea.<br><span>Shaped by you.</span></h2><p>QUIEVENT is a working, 3D-printed prototype. We’re refining the design and exploring a small first production run. Your interest helps us decide what comes next.</p></div></section>
      <section class="reserve" id="reserve"><div class="wrap reserve-content">
        <p class="eyebrow"><span class="cross" aria-hidden="true"></span> JOIN THE EARLY LIST</p>
        <h2>Ready for a<br><span>quieter kind of power?</span></h2>
        <p class="reserve-intro">Be among the first to hear about progress and availability. Your interest helps bring QUIEVENT closer to production.</p>
        <div class="price"><span>EXPECTED PRICE</span><strong>CHF 119 <small>approx.</small></strong></div>
        <div class="signup">
          <template v-if="status === 'success'"><h3>You’re on the list.</h3><p>Thank you for your interest in QUIEVENT. We’ll be in touch.</p></template>
          <template v-else><form @submit.prevent="reserve"><label for="email">Email address</label><input id="email" v-model="email" type="email" placeholder="you@example.com" autocomplete="email" required maxlength="254"><button type="submit" :disabled="status === 'loading'">{{ status === 'loading' ? 'Adding you…' : 'Join the interest list' }}</button><p v-if="status === 'error'" class="error" role="alert">{{ message }}</p></form><p class="form-note">No payment. No purchase commitment. Just updates on QUIEVENT.</p></template>
        </div>
      </div></section>
    </main>
    <footer class="footer wrap"><a class="brand" href="#top" aria-label="QUIEVENT home"><img :src="fanLogo" alt=""><img class="brand-word" :src="wordmarkLogo" alt="QUIEVENT"></a><p>Strong cooling. Quietly.</p><p>© {{ new Date().getFullYear() }} QUIEVENT</p></footer>
  </div>
</template>
<style>
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap');
:root{font-family:'DM Sans',sans-serif;background:#090b0d;color:#f5f6f6;scroll-behavior:smooth;font-synthesis:none}*{box-sizing:border-box}body{margin:0}a{color:inherit;text-decoration:none}img{display:block}.wrap{width:min(1180px,calc(100% - 80px));margin:auto}.header{height:92px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid #292d30}.brand{display:inline-flex;align-items:center;gap:12px}.brand>img:first-child{width:39px;height:39px}.brand-word{width:153px;height:auto}.nav-link{font-size:14px;font-weight:700;padding:10px 0;border-bottom:1px solid #777}.hero{text-align:center;padding:128px 0 80px}.eyebrow{display:flex;justify-content:center;align-items:center;gap:11px;color:#bbbfc1;font-size:12px;font-weight:700;letter-spacing:.18em}.cross{position:relative;width:16px;height:16px;background:#e60020}.cross:before,.cross:after{content:'';position:absolute;background:#fff;top:50%;left:50%;transform:translate(-50%,-50%)}.cross:before{width:9px;height:3px}.cross:after{height:9px;width:3px}h1,h2,h3,p,figure{margin:0}h1,h2{font-family:Manrope,sans-serif;letter-spacing:-.065em;font-weight:600}h1{font-size:clamp(62px,9.2vw,122px);line-height:1.02;margin:30px 0}h1 span,h2 span{color:#8b9295}.lead,.story>p:not(.eyebrow),.reserve-intro,.prototype-inner>p:last-child{color:#aeb4b6;line-height:1.75;font-size:18px;max-width:600px;margin:0 auto}.button{display:inline-block;background:#f2f5f5;color:#101416;font-size:14px;font-weight:700;padding:19px 29px;margin-top:34px;transition:background .2s}.button:hover{background:#0ac3e9}.hero-note{font-size:11px;letter-spacing:.14em;color:#858e91;margin-top:28px}.photo{position:relative;overflow:hidden;background:#14171a}.photo img{width:100%;height:min(69vw,760px);min-height:390px;object-fit:cover;object-position:center}.hero-photo img{object-position:center 53%}.photo:after{content:'';position:absolute;inset:60% 0 0;background:linear-gradient(transparent,rgba(0,0,0,.65));pointer-events:none}.photo figcaption{position:absolute;z-index:1;bottom:24px;left:40px;right:40px;display:flex;justify-content:space-between;gap:10px;color:#e1e6e7;font-size:11px;font-weight:700;letter-spacing:.14em}.photo figcaption span{color:#aeb4b6;font-weight:400}.story{text-align:center;padding:150px 0}.benefit-icon{width:76px;height:76px;border:1px solid #36454a;border-radius:50%;display:grid;place-items:center;margin:0 auto 26px;color:#08bce6;background:#11191c}.benefit-icon svg{width:39px;height:39px;stroke:currentColor;stroke-width:2;stroke-linecap:round;stroke-linejoin:round}.line{display:block;width:28px;height:2px;background:#06bde9}.story h2,.reserve h2,.prototype h2{font-size:clamp(43px,6vw,78px);line-height:1.12;margin:27px 0}.result-highlight{width:min(620px,100%);margin:36px auto 30px;padding:30px 24px;border-top:1px solid #3b5157;border-bottom:1px solid #3b5157;background:linear-gradient(90deg,transparent,#102027 50%,transparent)}.result-highlight strong{display:block;font:700 clamp(31px,5vw,52px)/1.12 Manrope,sans-serif;letter-spacing:-.045em;color:#f5f8f8}.result-highlight strong span{color:#12c6eb}.result-highlight p{color:#c4d0d2;font-size:15px;line-height:1.5;margin-top:12px}.story .observation{font-size:14px!important;line-height:1.7!important;color:#899296!important;max-width:570px!important;margin-top:28px!important}.prototype{padding:0 0 140px}.prototype-inner{border:1px solid #343b3d;padding:90px 30px;text-align:center;background:linear-gradient(140deg,#151a1c,#0c0f10)}.reserve{background:#f1f3f2;color:#121719;text-align:center;padding:140px 0}.reserve .eyebrow{color:#555}.reserve h2 span{color:#777f80}.reserve-intro{color:#626b6c}.price{margin:40px auto;display:flex;flex-direction:column;gap:10px}.price span{font-size:11px;letter-spacing:.17em;font-weight:700;color:#697172}.price strong{font:700 30px Manrope,sans-serif}.price small{font:400 14px 'DM Sans',sans-serif;color:#697172}.signup{max-width:480px;margin:0 auto;text-align:left}.signup label{font-size:14px;font-weight:700;display:block;margin-bottom:10px}.signup input{width:100%;height:56px;border:1px solid #aab3b3;background:white;padding:0 16px;font:16px 'DM Sans',sans-serif;border-radius:0}.signup button{width:100%;height:56px;margin-top:10px;background:#121719;color:#fff;border:0;font:700 14px 'DM Sans',sans-serif;cursor:pointer}.signup button:hover{background:#29373a}.signup button:disabled{opacity:.6;cursor:wait}.signup h3{font-size:24px}.signup p{line-height:1.6}.form-note{font-size:13px;color:#697172;margin-top:16px}.error{color:#b01f28;font-size:14px;margin-top:12px}.footer{padding:42px 0;display:flex;align-items:center;justify-content:space-between;gap:20px}.footer p{color:#929a9c;font-size:13px}@media(max-width:700px){.wrap{width:calc(100% - 40px)}.header{height:76px}.brand>img:first-child{width:32px;height:32px}.brand-word{width:122px}.nav-link{font-size:12px}.hero{padding:95px 0 65px}h1{font-size:clamp(54px,12vw,78px)}.photo img{height:74vw;min-height:310px}.photo figcaption{left:20px;right:20px;bottom:18px;font-size:10px}.story{padding:100px 0}.prototype{padding-bottom:95px}.prototype-inner{padding:65px 22px}.reserve{padding:100px 0}.footer{align-items:flex-start;flex-direction:column}}@media(prefers-reduced-motion:reduce){:root{scroll-behavior:auto}*{transition:none!important}}
</style>
