---
layout: post
title:  end to end UI test caveats
date:   2024-06-14 03:40
categories: tech 
---

I was troubled by the indeterministic behavour of UI test of one of my project. To the extent that I become afraid of the UI changes.

Recently, I decide to remove the cdn and include the frontend lib directly in the build, due to the cdn is not stable. An unexpected result happen, the UI test successfly run in a far better rate.

After some thoughts, I belive the root case of frontend UI test indeterministic is that cdn is not stable. I did not think of this before, because in my mindset, cdn is not a problem.

The lessson is minimizing the external dependency during test or production. less moving parts means a more stable product.
