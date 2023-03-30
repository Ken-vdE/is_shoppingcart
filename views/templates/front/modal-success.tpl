{extends file='components/modal.tpl'}

{block name='modal_extra_attribues'}id="blockcart-modal"{/block}
{block name='modal_title'}{l s='Product added to cart' d='Modules.Isshoppingcart.Modalsuccess'}{/block}


{block name='modal_body'}

  <div class="cart-products p-0 mb-4">
    <div class="cart-products__thumb">
      {images_block webpEnabled=$webpEnabled}
        <img
          class="img-fluid rounded"
          {generateImagesSources image=$product.default_image size='cart_default' lazyload=false}
          alt="{$product.cover.legend}"
          title="{$product.cover.legend}">
      {/images_block}
    </div>
    <div class="cart-products__desc">
        <p class="h6 mb-2 font-sm">
          {$product.name}
        </p>
        <div class="price price--sm">{$product.price}</div>
        {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    </div>
  </div>

  <hr>

  {if !empty($cart.subtotals.products.value)}
    <div class="cart-summary-line mb-2">
      <span class="label">{l s='Subtotal:' d='Modules.Isshoppingcart.Modalsuccess'}</span>
      <span class="value">{$cart.subtotals.products.value}</span>
    </div>
  {/if}

  {if !empty($cart.subtotals.shipping.value)}
    <div class="cart-summary-line mb-2">
      <span class="label">{l s='Shipping:' d='Modules.Isshoppingcart.Modalsuccess'}</span>
      <span class="value">{$cart.subtotals.shipping.value} {hook h='displayCheckoutSubtotalDetails' subtotal=$cart.subtotals.shipping}</span>
    </div>
  {/if}

  {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
    <div class="cart-summary-line cart-total mb-2">
      <span class="label">{$cart.totals.total.label}&nbsp;{$cart.labels.tax_short}</span>
      <span class="value">{$cart.totals.total.value}</span>
    </div>
    <div class="cart-summary-line cart-total mb-0">
      <span class="label">{$cart.totals.total_including_tax.label}</span>
      <span class="value">{$cart.totals.total_including_tax.value}</span>
    </div>
  {else}
    <div class="cart-summary-line cart-total mb-0">
      <span class="label">{$cart.totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$cart.labels.tax_short}{/if}</span>
      <span class="value">{$cart.totals.total.value}</span>
    </div>
  {/if}
{/block}

{block name='modal_footer'}
  {* Also see is_shoppingcart.tpl *}
  {*<custom> based on https://nemops.com/prestashop-show-free-shipping *}
  {assign var='freeshipping_price' value=Configuration::get('PS_SHIPPING_FREE_PRICE')}
  {if $freeshipping_price}
    {* Convert currency if required *}
    {assign var='freeshipping_price_converted' value={Tools::convertPrice($freeshipping_price)}}
    <div class="cart-summary-line cart-total col-12 justify-content-center">
      <span class="value">{l s='Free shipping from %amount%!' sprintf=['%amount%' => Tools::displayPrice($freeshipping_price_converted)] d='Shop.Theme.Global'}</span>
    </div>
    {*{math equation='a-b' a=$cart.totals.total.amount b=$cart.subtotals.shipping.amount assign='total_without_shipping'}
    {math equation='a-b' a=$freeshipping_price_converted b=$total_without_shipping assign='remaining_to_spend'}
    {if $remaining_to_spend > 0}
      <div class="cart-summary-line cart-total">
        <span class="value">{l s='Only %amount% until free shipping!' sprintf=['%amount%' => Tools::displayPrice($remaining_to_spend)] d='Shop.Theme.Global'}</span>
      </div>
    {/if}*}
  {/if}
  {*</custom>*}

  <a href="{$cart_url}" class="btn btn-primary btn-block">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
  <button type="button" class="btn btn-text btn-block" data-dismiss="modal">{l s='Continue shopping' d='Shop.Theme.Actions'}</button>
{/block}
